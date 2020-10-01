## code to prepare `world` dataset goes here
world <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")
usethis::use_data(world, overwrite = TRUE)
