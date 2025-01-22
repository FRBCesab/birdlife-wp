create_study_grid <- function(res = 100000, layer = NULL) {

  grille <- sf::st_make_grid(x        = layer, 
                             square   = TRUE, 
                             cellsize = c(res, res)) |>
    sf::st_sf()

  pos <- sf::st_intersects(grille, layer, sparse = FALSE)

  grille <- grille[pos, ]
  
  geom <- sf::st_geometry(grille)
  
  data <- data.frame("id" = 1:nrow(grille))

  sf::st_geometry(data) <- geom
  
  data
}
