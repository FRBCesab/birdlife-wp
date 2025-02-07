

create_occurrence_matrix <- function(presence = NULL, origin = NULL) {

  ## Check argument 'presence' ----

  if (!is.null(presence)) {

    if (!is.numeric(presence)) {
      stop("Argument 'presence' must be a numeric")
    }

    if (length(presence) != 1) {
      stop("Argument 'presence' must be of length 1")
    }

    if (is.na(presence)) {
      stop("Argument 'presence' cannot contain missing value.")
    }

    if (!(presence %in% 1:5)) {
      stop("Invalid value for 'presence' argument. ", 
           "Must be 1, 2, 3, 4, and/or 5")
    }
  }


  ## Check argument 'origin' ----
  
  if (!is.null(origin)) {

    if (!is.numeric(origin)) {
      stop("Argument 'origin' must be a numeric")
    }

    if (length(origin) != 1) {
      stop("Argument 'origin' must be of length 1")
    }

    if (is.na(origin)) {
      stop("Argument 'origin' cannot contain missing value.")
    }

    if (!(origin %in% 1:5)) {
      stop("Invalid value for 'origin' argument. ", 
           "Must be 1, 2, 3, 4, and/or 5")
    }
  }


  ## Open study area (Western Palearctic grid) ----

  filename <- "western_palearctic_grid.gpkg"
  datapath <- here::here("data")

  if (!file.exists(file.path(datapath, filename))) {
    stop("The file '", filename, "' does not exist in '", datapath, "/'")
  }

  study_area <- sf::st_read(file.path(datapath, filename))


  ## Store final CRS ----

  laea_proj <- sf::st_crs(study_area)


  ## Open BirdLife spatial polygons (selected species) ----

  filename <- "birdlife_selected_species.gpkg"
  datapath <- here::here("data", "BirdLife")

  if (!file.exists(file.path(datapath, filename))) {
    stop("The file '", filename, "' does not exist in '", datapath, "/'")
  }

  birdlife <- sf::st_read(file.path(datapath, filename))


  ## Clean species name ----
  birdlife$"blife_binomial" <- tolower(gsub(" ", "_", 
                                            birdlife$"blife_binomial"))

  
  ## Get species names ----

  sp_names <- birdlife[ , "blife_binomial", drop = TRUE] |> 
    unique() |> 
    sort()


  ## Select polygons based on presence ----

  if (!is.null(presence)) {
    birdlife <- birdlife[birdlife$"blife_presence" %in% presence, ]
  }


  ## Select polygons based on origin ----

  if (!is.null(origin)) {
    birdlife <- birdlife[birdlife$"blife_origin" %in% origin, ]
  }


  ## Check if values ----

  if (nrow(birdlife) == 0) {
    stop("No available data for required presence and origin")
  }


  ## Project study area in WGS84 ----

  study_area <- sf::st_transform(study_area, crs = sf::st_crs(birdlife))


  ## Report occurrences on grid ----

  species <- birdlife[ , "blife_binomial", drop = TRUE] |> 
    unique() |> 
    sort()

  grids <- parallel::mclapply(species, function(sp) {
    tmp <- birdlife[birdlife$"blife_binomial" == sp, ]
    tmp <- sf::st_make_valid(tmp)
    grd <- polygon_to_grid(study_area, tmp)
    grd
  }, mc.cores = 20)
  

  ## Aggregation ----

  grids <- do.call(cbind, grids)
  grids <- grids[ , which(colnames(grids) != "id")]


  ## Add missing species ----

  pos <- which(!(sp_names %in% species))

  if (length(pos) > 0) {
    grids[sp_names[pos]] <- 0
  }

  grids <- grids[ , sp_names]


  ## Add cells ID ----

  grids <- data.frame(id       = study_area$"id", 
                      presence = ifelse(!is.null(presence), presence, "all"),
                      origin   = ifelse(!is.null(origin),   origin,   "all"),
                      grids)


  ## Convert to spatial object ----
  
  sf::st_geometry(grids) <- sf::st_geometry(study_area)


  ## Project to LAEA ----

  grids <- sf::st_transform(grids, crs = laea_proj)


  ## Export layer ----

  filename <- paste0("occ_matrix", 
                     "_presence_", ifelse(is.null(presence), "all", presence), 
                     "_origin_",   ifelse(is.null(origin),   "all", origin),
                     ".gpkg")
  
  sf::st_write(grids, here::here("outputs", filename))
  

  invisible(grids)
}
