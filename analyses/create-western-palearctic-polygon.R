#' Create the study area: Western Palearctic
#' 
#' Uses the WWF Terrestrial Ecoregions of the World (TEOW) shapefile and the 
#' Natural Earth (World country boundaries, package `rnaturalearth`) shapefile
#' to create this study area.
#' 
#' Five files are created and saved in `data/`:
#'   - `western_palearctic_boundaries.gpkg`
#'   - `western_palearctic_biomes.gpkg`
#'   - `western_palearctic_ecoregions.gpkg`
#'   - `western_palearctic_grid.gpkg`
#'   - `western_palearctic_cropped_grid.gpkg`
#'   
#' All these spatial polygons (package `sf`) are defined in the Lambert 
#' Azimuthal Equal Area projection system.


## Load project ----

devtools::load_all()


## Do not use the 's2' spherical geometry package ----

sf::sf_use_s2(FALSE)


## Define final coordinate system ----

laea_proj <- "+proj=laea +lon_0=24.81956 +lat_0=42.82692"


## Import WWF TEOW ecoregions ----

wwf <- sf::st_read(here::here("data", "Terrestrial_Ecoregions_World", 
                              "Terrestrial_Ecoregions_World.shp"))


## Select ecoregions of the Palearctic realm ----

palearctic <- wwf[wwf$"REALM" == "PA", ]


## Select Rock and Ice and Lake ecoregions (Sweden, Svalbard, Finland & Russia) ----

ices_lakes <- wwf[is.na(wwf$"REALM"), ]


## Append layers ----

palearctic <- rbind(palearctic, ices_lakes)


## Get World country boundaries (Natural Earth) ----

world <- rnaturalearth::ne_countries(scale = "large")


## European countries to select ----

europe <- c("France", "Ukraine", "Belarus", "Lithuania", "Russia", "Czechia", 
            "Germany", "Estonia", "Latvia", "Norway", "Sweden", "Finland",
            "Luxembourg", "Belgium", "North Macedonia", "Albania", "Kosovo", 
            "Spain", "Denmark", "Romania", "Hungary", "Slovakia", "Poland", 
            "Ireland", "United Kingdom", "Greece", "Austria", "Italy", 
            "Switzerland", "Netherlands", "Liechtenstein", "Republic of Serbia",
            "Croatia", "Slovenia", "Bulgaria", "San Marino", "Monaco", 
            "Andorra", "Montenegro", "Bosnia and Herzegovina", "Portugal", 
            "Moldova", "Gibraltar", "Vatican", "Iceland", "Malta", "Jersey", 
            "Guernsey", "Isle of Man", "Aland", "Faroe Islands")


## African countries to select ----

africa <- c("Morocco", "Algeria", "Tunisia", "Libya", "Egypt", "Western Sahara",
            "Mauritania", "Mali", "Niger", "Chad", "Sudan")


## Asian countries to select ----

asia   <- c("Israel", "Yemen", "Oman", "United Arab Emirates", "Saudi Arabia",
            "Qatar", "Qatar", "Kuwait", "Palestine", "Jordan", "Iraq", "Iran",
            "Lebanon", "Syria", "Turkey", "Cyprus", "Cyprus No Mans Area", 
            "Dhekelia Sovereign Base Area", "Akrotiri Sovereign Base Area", 
            "Azerbaijan", "Armenia", "Georgia", "Turkmenistan", "Uzbekistan", 
            "Kazakhstan", "Baykonur Cosmodrome", "Northern Cyprus",
            "Turkish Republic of Northern Cyprus")


## Select World countries ----

world <- world[world$"geounit" %in% c(europe, africa, asia), ]


## Dissolve geometry ----

world <- sf::st_union(world)


## Subset Palearctic ecoregions intersecting these countries ----

palearctic <- sf::st_intersection(palearctic, world)


## Click on the map to identify ecoregions ----

# plot(palearctic[ , "BIOME"], lwd = 0.5, col = "red", reset = TRUE)
# plot(sf::st_geometry(world), add = TRUE)
# 
# 
# create_clipper <- function() {
# 
#   x <- locator()
# 
#   cbind("lon" = c(x$x, x$x[1]), "lat" = c(x$y, x$y[1])) |>
#     list() |>
#     sf::st_polygon() |>
#     sf::st_sfc() |>
#     sf::st_as_sf(crs = 4326)
# }
# 
# biome <- palearctic[palearctic$"BIOME" == 13, ]
# 
# plot(biome[ , "BIOME"], lwd = 0.5, col = "red", reset = FALSE)
# plot(sf::st_geometry(world), add = TRUE)
# 
# clipper <- create_clipper()
# plot(sf::st_geometry(clipper), add = TRUE)
# 
# regions <- sf::st_intersection(biome, clipper)
# regions$"OBJECTID"


## Biome  4 - Temperate broadleaf and mixed forests ----

region_04 <- c(6838, 6844, 7245, 2791, 2798, 2800, 2242, 2245, 2204, 2206, 2221,
               2233, 2234, 6311, 6319, 6222, 6232, 2725, 5797, 5798, 5799, 6864,
               6866, 7055, 7056, 7068, 5720, 6417, 6418, 6419, 6427, 7605, 7606,
               7134, 7175, 7177, 6126, 6128, 6136, 6687, 6691, 6695, 6803, 6804,
               6805, 6809, 6832, 6833, 6834, 6855, 6856, 6860, 6861, 6862, 6872,
               6876, 7362, 7364, 7374, 6320, 6328, 7089, 7155, 5608, 5704, 5740,
               5751, 5753, 5760, 5761, 5769, 5770, 5776, 5791, 5820, 5824, 5826,
               5830, 5832, 5834, 5838, 5842, 5843, 5845, 5850, 5855, 5858, 5932,
               5933, 5934, 5939, 5940, 5941, 5948, 5950, 5955, 5957, 5982, 5994,
               6019, 6021, 6045, 6049, 6054, 6055, 6056, 6058, 6066, 6076, 6083,
               6087, 6091, 6101, 6116, 6119, 6120, 6148, 6150, 6156, 6161, 6166,
               6167, 6169, 6171, 6178, 6181, 6184, 6188, 6191, 6194, 6196, 6197,
               6199, 6201, 6203, 6205, 6206, 6210, 6211, 6239, 6244, 6245, 6248,
               6253, 6258, 6261, 6263, 6266, 6272, 6273, 6284, 6285, 6288, 6297,
               6300, 6301, 6306, 6309, 6332, 6338, 6346, 6355, 6358, 6364, 6371, 
               6373, 6383, 6385, 6388, 6393, 6395, 6403, 6404, 6433, 6437, 6439,
               6459, 6466, 6467, 6468, 6469, 6475, 6489, 6491, 6497, 6503, 6507,
               6526, 6532, 6550, 6553, 6559, 6563, 6569, 6581, 6582, 6584, 6589,
               6603, 6606, 6613, 7263, 6622, 6634, 6635, 6641, 6651, 6667, 6676,
               6677, 6708, 6714, 6715, 6717, 6722, 6729, 6731, 6732, 6735, 6744,
               6752, 6755, 6756, 6767, 6768, 6770, 6772, 6791, 6814, 7521, 7524,
               6822, 6826, 6830, 6883, 6889, 7004, 7035, 7037, 7039, 7042, 7046,
               7078, 7081, 7111, 7139, 7142, 7191, 7255, 7308, 7315, 7331, 7348,
               7387, 7403, 7426, 7429, 7438, 7442, 7446, 7468, 7501, 7504, 7513,
               7532, 7538, 7546, 7552, 7566, 7570, 7571, 7632, 7662, 7673, 7680,
               7906, 5884, 8333, 8338, 8343, 8348, 8350, 8358)


## Biome  5 - Temperate coniferous forests ----

region_05 <- c(2776, 5099, 5311, 2697, 2702, 2716, 2191, 2196, 2218, 2723, 2749,
               5402, 5708, 7132, 8303, 4452, 4481, 4497, 4505, 4506, 4535, 4558,
               4560, 4578, 4597, 4600, 4954, 4958, 4640, 4650, 4666, 4668, 4675,
               4725, 4734, 4817, 4818, 4829, 4840, 4866, 4903, 5543, 4935, 5027, 
               6322, 5199, 5204, 5232, 5263, 5268, 5269, 5360, 5364, 5366, 5391,
               5463, 5480, 5546, 5556, 5560, 5562, 5567, 5596, 5628, 5678, 5687,
               5689, 5703, 5748, 5756, 5762, 5772, 5865, 6044, 6050, 6052, 6081,
               6093, 6100, 6105, 6144, 6170, 6175, 6193, 6212, 6295, 6923, 6936,
               7260, 7320, 7612, 7720, 7968, 7987, 8026, 8076, 8286, 8347)


## Biome  6 - Taiga ----

region_06 <- c(5649, 5310, 5312, 4998, 5006, 5009, 2719, 5801, 5410, 5413, 5709,
               4329, 5515, 5641, 4960, 4963, 4728, 4790, 4799, 4804, 4807, 4868,
               4936, 4942, 4946, 4973, 4981, 4995, 5026, 5029, 5054, 5094, 5115,
               5118, 5120, 5224, 5236, 5238, 5246, 5249, 5327, 5329, 5337, 5347,
               5351, 5354, 5428, 5448, 5460, 5477, 5588, 5594, 5598, 5615, 5622,
               5626, 5653, 5659, 5660, 5661, 5663, 5674, 5675, 5676, 5686, 5690,
               5819, 5833, 5837, 5931, 6046, 6064, 6077, 6082, 6177, 6268, 6360,
               6452, 6498)


## Biome  8 - Temperate grasslands, savannas, and shrublands ----

region_08 <- c(2211, 7874, 7365, 6740, 7385, 7404, 7413, 7469, 7689, 7692, 7702,
               7709, 5552, 5554, 5555, 5559, 5561, 5565, 5566, 5579, 5603, 5634)


## Biome  9 - Flooded grasslands and savannas ----

region_09 <- c(8752, 8753, 5876, 8176, 8469, 8392, 8060, 8127, 8191, 8294, 8315, 
               8324, 8342, 8410, 8411, 8624, 8636, 8736, 8888, 8916, 9071, 9082,
               9132, 9180, 9186, 9215, 9254, 9466, 9607, 14818)


## Biome 10 - Montane grasslands and shrublands ----

region_10 <- c(8297, 8378, 8196, 8293, 8349, 8429, 8447)


## Biome 11 - Tundra ----

region_11 <- c(4197, 4290, 4292, 4294, 4297, 2622, 2624, 2625, 2627, 2689, 2695, 
               2678, 4008, 4182, 4189, 3758, 3760, 3762, 3764, 4053, 2155, 4316,
               4320, 2641, 2643, 2646, 2748, 4417, 4421, 3498, 3501, 3799, 3807, 
               3809, 3875, 4306, 4308, 4311, 4312, 4324, 4326, 4336, 4340, 3511, 
               3517, 3685, 3688, 3694, 3696, 3697, 3700, 3701, 3703, 3706, 3707, 
               3708, 3709, 3715, 3716, 3717, 3718, 3720, 3722, 3723, 3725, 3728, 
               3732, 3736, 3738, 3739, 3740, 3742, 3743, 3745, 3747, 3748, 3750, 
               3753, 3782, 3789, 3792, 3795, 3826, 3902, 4028, 4225, 4257, 4271, 
               4272, 4323, 4343, 4382, 4402, 4432, 4445, 4538, 4543, 4778, 4792,
               4800, 4802, 4806, 4821, 4824, 4858, 5534, 5320)


## Biome 12 - Mediterranean forests, woodlands, and scrub ----

region_12 <- c(2238, 5889, 7743, 7592, 7594, 7598, 7607, 6908, 6916, 6919, 7486,
               7869, 7877, 7879, 7882, 8311, 8757, 7736, 7738, 5874, 5878, 5879,
               6031, 6034, 6036, 7764, 7765, 7770, 8170, 8825, 8831, 7520, 8084,
               8088, 8091, 8093, 8905, 6920, 6930, 6931, 6933, 6934, 6940, 6943,
               7393, 7417, 7775, 7778, 7788, 7441, 7443, 7448, 7463, 7470, 7471,
               7472, 7509, 7510, 7530, 7536, 7544, 7547, 7554, 7558, 7559, 7562,
               7563, 7565, 7567, 7573, 7575, 7577, 7582, 7583, 7590, 7618, 7628,
               7629, 7631, 7635, 7636, 7641, 7642, 7647, 7651, 7654, 7655, 7657,
               7660, 7668, 7670, 7672, 7675, 7676, 7681, 7684, 7690, 7697, 7700,
               7703, 7707, 7708, 7715, 7718, 7721, 7724, 7747, 7750, 7753, 7754,
               7756, 7760, 7796, 7797, 7802, 7803, 7805, 7809, 7810, 7811, 7814,
               7815, 7816, 7820, 7822, 7831, 7832, 7835, 7837, 7838, 7839, 7843,
               7853, 7865, 7866, 7867, 7884, 7885, 7886, 7896, 7897, 7898, 7899,
               7901, 7994, 7996, 8000, 8001, 8002, 8003, 8129, 8135, 8137, 8139,
               8372, 8374, 7907, 7908, 7909, 7913, 7915, 7917, 7920, 7923, 7934,
               7936, 7938, 7940, 7945, 7949, 7952, 7957, 7958, 7959, 7961, 7963,
               7965, 7969, 7973, 7974, 7976, 7977, 7979, 7980, 7985, 7990, 8004,
               8006, 8008, 8012, 8015, 8017, 8019, 8020, 8023, 8025, 8028, 8030,
               8031, 8032, 8034, 8044, 8050, 8053, 8055, 8057, 8063, 8064, 8075,
               8081, 8099, 8106, 8108, 8125, 8126, 8158, 8160, 8185, 8186, 8280,
               8318, 8322, 8323, 8331, 8335, 8339, 8340, 8363, 8403, 8419, 8424,
               8432, 8492, 8762, 8844, 8861, 8878, 8882, 8906)


## Biome 13 - Deserts and xeric shrublands ----

region_13 <- c(9048, 8299, 5875, 8089, 8092, 8097, 6932, 6954, 6961, 9581, 9590, 
               9591, 9592, 7614, 8394, 9089, 8018, 8066, 8109, 8155, 8284, 8288,
               8406, 8451, 8489, 8491, 8617, 8626, 8660, 8704, 8725, 8967, 8999,
               9010, 9030, 9040, 9073, 9114, 9120, 9131, 9168, 9174, 9211, 9258,
               9263, 9264, 9288, 9292, 9316, 9331, 9365, 9461, 9513, 9532, 9538,
               9563, 9564, 9573, 9574, 9577, 9685, 14819, 14820)


## Other ecoregions (Ice, rock and lakes) ----

others <- c(5103, 5107, 5111, 5234, 5449, 5620, 6143)


## Select ecoregions based on OBJECTID (defined manually) ----

wp_ecoregions <- palearctic[palearctic$"OBJECTID" %in% c(region_04, region_05, 
                                                         region_06, region_08, 
                                                         region_09, region_10,
                                                         region_11, region_12,
                                                         region_13, others), ]


## Aggregate by biome ----

wp_biomes <- wp_ecoregions |> 
  dplyr::group_by(BIOME) |> 
  dplyr::summarize() |> 
  dplyr::ungroup()


## Dissolve geometry (Western Palearctic boundaries) ----

wp_boundaries <- sf::st_union(wp_ecoregions)


## Project polygons ----

wp_ecoregions <- wp_ecoregions |> 
  sf::st_transform(crs = laea_proj)

wp_biomes <- wp_biomes |> 
  sf::st_transform(crs = laea_proj)

wp_boundaries <- wp_boundaries |> 
  sf::st_transform(crs = laea_proj)


## Create grid ----

study_grid         <- create_study_grid(res   = 100000, 
                                        layer = wp_boundaries)

study_cropped_grid <- sf::st_intersection(study_grid, wp_boundaries)


## Export layers ----

sf::st_write(wp_ecoregions, 
             here::here("data", "western_palearctic_ecoregions.gpkg"))

sf::st_write(wp_biomes, 
             here::here("data", "western_palearctic_biomes.gpkg"))

sf::st_write(wp_boundaries, 
             here::here("data", "western_palearctic_boundaries.gpkg"))

sf::st_write(study_grid, 
             here::here("data", "western_palearctic_grid.gpkg"))

sf::st_write(study_cropped_grid, 
             here::here("data", "western_palearctic_cropped_grid.gpkg"))


## Additional data for map ----

world <- rnaturalearth::ne_countries(scale = "large")
world <- sf::st_transform(world, crs = laea_proj)

ocean <- sf::st_union(world)


## Map layers and study area ----

ggplot2::ggplot() +
  
  ggplot2::geom_sf(data      = world,
                   fill      = "#FFFFFFFF", 
                   linewidth = 0.1) +
  
  ggplot2::geom_sf(data      = ocean, 
                   fill      = NA, 
                   col       = "#85cff0FF", 
                   linewidth = 0.1) +
  
  ggplot2::geom_sf(data      = wp_boundaries, 
                   fill      = "#00000022", 
                   col       = "#000000FF") +
  
  ggplot2::geom_sf(data      = study_grid, 
                   fill      = NA, 
                   col       = "#7F0000FF") +
  
  ggplot2::coord_sf(xlim   = c(-4500000, 3750000), 
                    ylim   = c(-3150000, 4550000), 
                    expand = FALSE) +
  
  ggplot2::theme_bw() +
  
  ggplot2::ggtitle("Western Palearctic") +
  
  ggplot2::labs(caption = "Lambert Azimuthal Equal Area projection") +
  
  ggplot2::theme(
    
    plot.title = ggplot2::element_text(margin = ggplot2::margin(b = -40, l = 30),
                                       face   = "bold", 
                                       color  = "#373737FF", 
                                       size   = 20),
    
    panel.background = ggplot2::element_rect(fill = "#C0E4F8FF"),
    
    panel.grid.major = ggplot2::element_line(linewidth = 0.2,
                                             color = "#85CFF0FF"),
    
    plot.caption = ggplot2::element_text(face  = "italic", 
                                         color = "#373737FF", 
                                         size  = 9,
                                         hjust = 1,
                                         vjust = -4),
    
    text = ggplot2::element_text(family = "serif"))

ggplot2::ggsave(filename = here::here("figures", "study_area.png"), 
                width    = 12.5, 
                height   = 12, 
                dpi      = 300)
