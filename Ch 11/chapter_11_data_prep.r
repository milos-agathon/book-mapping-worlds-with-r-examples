# --- Script: chapter_11_data_prep.R --- 
# (Can be in same script)

# Step 1: Get World Polygons
print("Getting world polygons...")
world_polygons_anim <- rnaturalearth::ne_countries(
  scale = 'medium',
  returnclass = 'sf') |>
  # Keep only a few columns, ensure we have a consistent country 
  # code (ISO A3)
  # adm0_a3 is a good ISO 3-letter code from rnaturalearth
  dplyr::select(iso_a3 = adm0_a3, name, geometry) |>
  # Filter out Antarctica for a cleaner map
  dplyr::filter(name != "Antarctica")
print("World polygons loaded.")

# Step 2: Get gapminder data and add matching ISO codes
print("Preparing gapminder data...")
gapminder_data_anim <- gapminder::gapminder |>
  # Create an iso_a3 column using countrycode to match the polygons
  dplyr::mutate(
    iso_a3 = suppressWarnings(
      countrycode::countrycode(
        country,
        origin = 'country.name',
        destination = 'iso3c'))) |>
  # Keep only needed columns (the key, the time variable, and data 
  # to map)
  dplyr::select(iso_a3, country, year, lifeExp, pop, gdpPercap) |>
  # Remove rows where country code couldn't be matched
  dplyr::filter(!is.na(iso_a3))
print("Gapminder data prepared.")

# Step 3: Join spatial polygons with time series data
print("Joining spatial and time series data...")
# Use a left_join to keep all polygons and add matching gapminder 
# data
# A country might not have data for every single year in gapminder
world_gapminder_sf <- world_polygons_anim |>
  dplyr::left_join(gapminder_data_anim, by = "iso_a3")
print("Data prepared and joined.")
print("Checking joined data structure:")
dplyr::glimpse(world_gapminder_sf)
# Note: Each country polygon is now repeated for each year it has 
# data!
# Also check for NAs in the joined columns 
# (lifeExp, pop, gdpPercap)
print(
  paste(
    "Total rows in joined data:", 
    nrow(world_gapminder_sf)
  )
)
print(
  paste(
    "Number of unique countries:", 
    dplyr::n_distinct(world_gapminder_sf$iso_a3)
  )
)
print(
  paste(
    "Number of unique years:", 
    dplyr::n_distinct(world_gapminder_sf$year)
  )
)

# Store for later use
assign(
  "world_gapminder_sf", world_gapminder_sf, 
  envir = .GlobalEnv
)