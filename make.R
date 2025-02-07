#' birdlife-wp: A Research Compendium
#' 
#' @description 
#' A paragraph providing a full description of the project and describing each 
#' step of the workflow.
#' 
#' @author Nicolas Casajus \email{rdev.nc@gmail.com}
#' 
#' @date 2025/01/20



## Install Dependencies (listed in DESCRIPTION) ----

devtools::install_deps(upgrade = "never")


## Load Project Addins (R Functions and Packages) ----

devtools::load_all(here::here())


## Do not use the 's2' spherical geometry package ----

sf::sf_use_s2(FALSE)


## Run Project ----

### Step 1: Create study area ----

# source(here::here("analyses", "create-western-palearctic-polygon.R"))


### Subset BirdLife polygons of required species ----

# select_birdlife_species_polygons()


### Create Cell x Species occurrence matrix ----

# Extant & Native
create_occurrence_matrix(presence = 1, origin = 1)

# Extant & Introduced
create_occurrence_matrix(presence = 1, origin = 3)

# Extinct & Native
create_occurrence_matrix(presence = 5, origin = 1)

## Explore ----

# x <- sf::st_read(here::here("outputs", 
#                             "occ_matrix_presence_1_origin_1.gpkg"))

# library(ggplot2)

# ggplot(x) + 
#   geom_sf(aes(fill = upupa_epops))
