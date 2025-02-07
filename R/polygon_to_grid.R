polygon_to_grid <- function(grid, polygon) {
 
  species <- polygon$"blife_binomial" |> 
    unique()
  
  ## Intersect layers ----
  cells <- sf::st_intersects(grid, polygon, sparse = FALSE)
  cells <- apply(cells, 1, any)
  cells <- which(cells)
  
  ## Create presence/absence column ----
  grid[     , species] <- 0
  grid[cells, species] <- 1
  
  ## Remove spatial information ----
  sf::st_drop_geometry(grid)
}
