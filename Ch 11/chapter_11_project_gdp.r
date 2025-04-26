# --- Script: chapter_11_project_gdp.R ---

# Step 1: Setup
print("Loading packages for GDP Animation Exercise...")
pacman::p_load(gganimate,
               sf,
               tidyverse,
               gapminder,
               rnaturalearth,
               countrycode,
               gifski,
               scales)

# Step 2: Get world boundaries and join with gapminder data

world_sf <- rnaturalearth::ne_countries(
  scale = 'medium',
  returnclass = 'sf') |>
  dplyr::select(iso_a3 = adm0_a3, name, geometry) |>
  dplyr::filter(
    name != "Antarctica" # remove Antarctica
  )

# Filter gapminder for all years and add ISO codes
gdp_pc_df <- gapminder::gapminder |>
  dplyr::select(country, gdpPercap, year) |>
  dplyr::mutate(iso_a3 = suppressWarnings(
    countrycode::countrycode(
      country, origin = 'country.name', 
      destination = 'iso3c')
  ))

# Join GDP per capita to polygons
gdp_pc_sf <- world_sf |>
  dplyr::left_join(gdp_pc_df, by = "iso_a3")

# Step 3: Create Base ggplot
print("Creating base ggplot for GDP animation...")
base_gdp_map <- ggplot(data = gdp_pc_sf) +
  geom_sf(aes(fill = gdpPercap),
          color = "white",
          linewidth = 0.1) +
  # Use log10 scale for skewed GDP data
  scale_fill_viridis_c(
    option = "viridis",
    name = "GDP/Cap (log10)",
    trans = "log10",
    labels = scales::label_log(digits = 2),
    na.value = "lightgrey"
  ) +
  theme_void() +
  theme(
    legend.position = "bottom",
    legend.key.width = unit(1.5, "cm"),
    plot.title = element_text(
      hjust = 0.5, size = 16, face = "bold"),
    plot.caption = element_text(size = 8, hjust = 0.95)
  )

# Step 4: Add Animation Layers
print("Adding animation layers...")
gdp_animation <- base_gdp_map +
  transition_time(year) +
  labs(
    title = "GDP per Capita in {as.integer(frame_time)}", 
    caption = "Data: Gapminder (GDP/Cap on log10 scale)") +
  ease_aes('cubic-in-out') # Try a different easing

# Step 5: Render and Save
output_gdp_gif <- "gdp_animation.gif"
print(
  paste(
    "Saving GDP animation:", 
    output_gdp_gif, "(takes time!)...")
  )

anim_save(
  filename = output_gdp_gif,
  animation = gdp_animation,
  nframes = 200,
  # Adjust frame count
  fps = 15,
  # Adjust speed
  width = 800,
  height = 500,
  res = 100,
  renderer = gifski_renderer()
)
print("GDP animation saved.")

# Step 6: View (Manually open the file)
print(paste("View the saved animation:", output_gdp_gif))