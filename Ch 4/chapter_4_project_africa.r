# --- Script: chapter_4_project_africa.R ---

# Step 1: Setup
print("Loading packages for Africa Exercise...")
pacman::p_load(
  sf, tidyverse, rnaturalearth, gapminder, countrycode
)

# Step 2: Prepare Data
print("Preparing African data...")
# Get African polygons
africa_sf <- rnaturalearth::ne_countries(
  scale = 'medium',
  continent = 'Africa',
  returnclass = 'sf') |>
  dplyr::select(iso_a3 = adm0_a3, name, geometry)

# Filter gapminder for latest year and add ISO codes
latest_year <- max(gapminder::gapminder$year)
gapminder_latest <- gapminder::gapminder |>
  dplyr::filter(year == latest_year) |>
  dplyr::select(country, lifeExp) |>
  dplyr::mutate(iso_a3 = suppressWarnings(
    countrycode::countrycode(
      country, origin = 'country.name', 
      destination = 'iso3c')
  ))

# Join life expectancy to polygons
africa_life_exp_sf <- africa_sf |>
  dplyr::left_join(gapminder_latest, by = "iso_a3") |>
  dplyr::filter(!is.na(lifeExp)) # Keep only countries with data

print("Data prepared.")

# Step 3: Create Plot
print("Creating Africaan Life Expectancy map...")
africa_map_plot <- ggplot(data = africa_life_exp_sf) +
  geom_sf(aes(fill = lifeExp),
          color = "white",
          linewidth = 0.1) +
  scale_fill_viridis_c(
    option = "viridis",
    direction = -1,
    name = "Life Exp.",
    na.value = "grey80") +
  labs(
    title = paste("African Life Expectancy", latest_year),
    caption = "Data: Gapminder & Natural Earth") +
  theme_void() +
  theme(
    legend.position.inside = c(0.15, 0.8),
    # Semi-transparent background
    plot.title = element_text(hjust = 0.5, face = "bold"),
    plot.caption = element_text(hjust = 0.95, vjust = 50)
  )

print(africa_map_plot)
print("Africa map created.")

ggsave(
  "africa_map_.png",
  plot = africa_map_plot, 
  width = 7, height = 8, 
  bg = "white", dpi = 600
)