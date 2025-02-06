#' Import Bird Life polygons and select polygons for selected species
#'
#' @description Before using this function, user needs to request the Birds 
#' of the World spatial data at:
#' \url{https://datazone.birdlife.org/species/requestdis} 
#' and download the ZIP file from the link sent by email. The content of the ZIP
#' (folder `BOTW_XXX/`) must be extracted in the folder `data/` and renamed as 
#' `BIRDS/`. This function will then read the file `data/BIRDS/BOTW.gdb`.
#'
#' @return A `MULTIPOLYGON` object (package `sf`).
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' select_birdlife_species_polygons()
#' }

select_birdlife_species_polygons <- function(path = here::here("data", 
                                                               "BirdLife")) {
  
  ## Check path ----
  
  if (!dir.exists(path)) {
    stop("The directory '", path, "' does not exist. Did you download the ", 
         "Birds of the World spatial data and extract the content of the ZIP ", 
         "file in '", path, "'?", call. = FALSE)
  }
  
  
  ## Do not use the 's2' spherical geometry package ----
  
  sf::sf_use_s2(FALSE)
  
  
  ## Import spatial layer ----
  
  if (!file.exists(file.path(path, "BOTW.gdb"))) {
    stop("The file 'BOTW.gdb' does not exist in '", path, "/'.", call. = FALSE)
  }
  
  data <- sf::st_read(file.path(path, "BOTW.gdb"), layer = "All_Species")
  
  
  ## Drop geometry (temporary) ----
  
  geometry <- sf::st_geometry(data)
  data     <- sf::st_drop_geometry(data)
  
  
  ## Select columns ----
  
  data <- data[ , c("sisid", "sci_name", "presence", "origin", "seasonal")]
  
  
  ## Clean data ----
  
  colnames(data)[1:2] <- c("id", "binomial")
  
  colnames(data) <- paste0("blife_", colnames(data))
  
  
  ## Add geometry ----
  
  sf::st_geometry(data) <- geometry
  
  
  ## Import species list ----
  
  splist <- read.csv2(file.path(path, "species_list.csv"))
  
  
  ## Select polygons for the species list ----
  
  data <- data[data$"blife_binomial" %in% splist$"birdlife_latin", ]
  
  
  ## Keep seasonal == 1 & 2 ----
  
  data <- data[data$"blife_seasonal" %in% c(1, 2), ]
  
  
  ## Keep origin == 1, 2 & 3 ----
  
  data <- data[data$"blife_origin" %in% c(1, 2, 3), ]
  
  
  ## Keep presence == 1 & 5 ----
  
  data <- data[data$"blife_presence" %in% c(1, 5), ]
  
  
  ## Remove MULTISURFACE polygons ----
  
  geom_type <- as.character(sf::st_geometry_type(data))
  
  data <- data[which(geom_type == "MULTIPOLYGON"), ]
  
  
  ## Correct geometry ----
  
  # data <- sf::st_make_valid(data)
  
  
  ## Crop w/ study area boundaries ----
  
  bbox <- sf::st_bbox(obj = c(xmin = -30, ymin = 10, 
                              xmax =  75, ymax = 85),
                      crs = sf::st_crs(4326)) |>
    sf::st_as_sfc() |>
    sf::st_as_sf()
  
  data <- sf::st_crop(data, bbox)
  
  
  ## Export layer ----
  
  sf::st_write(data, file.path(path, "birdlife_selected_species.gpkg"))
  
  invisible(data)
}
