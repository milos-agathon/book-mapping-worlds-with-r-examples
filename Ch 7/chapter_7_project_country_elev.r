# --- Script: chapter_7_project_country_elev.R ---

# Step 1: Choose Country & Setup
print("Loading packages for Country Elevation Exercise...")
pacman::p_load(sf, tidyverse, terra, geodata)
theme_set(theme_minimal())

# --- USER INPUT: SET YOUR COUNTRY ISO CODE HERE ---
# Example: Use "NPL" for Nepal, "NZL" for New Zealand,
# "ITA" for Italy
your_iso_code <- "NPL"
your_country_name <- "Nepal" # For title
# -------------------------------------------------

# Step 2: Download/Load Elevation
print(paste(
  "Fetching 30s elevation data for",
  your_country_name,
  "(may take time)..."
))

my_country_elev <- geodata::elevation_30s(
  country = your_iso_code, path = tempdir())
print("Elevation data loaded.")
# Rename the layer for easier use later
names(my_country_elev) <- "elevation"

# Step 3: Inspect
print("--- Elevation Raster Summary ---")
print(my_country_elev)
print("--- Elevation CRS ---")
print(terra::crs(my_country_elev))

# Step 4: Map with ggplot2
print("Converting raster to data frame...")
# Use na.rm=TRUE in as.data.frame for efficiency
elev_df <- terra::as.data.frame(
  my_country_elev, xy = TRUE, na.rm = TRUE
)

print("Creating ggplot map...")
my_country_map <- ggplot(data = elev_df) +
  geom_raster(aes(x = x, y = y, fill = elevation)) +
  # Try different viridis options: "mako", "rocket",
  # "turbo", "viridis"
  scale_fill_viridis_c(
    option = "mako",
    direction = -1,
    name = "Elevation (m)"
    ) +
  labs(title = paste("Elevation Map of", your_country_name),
       caption = "Data: SRTM 30s via geodata") +
  coord_sf(
    crs = terra::crs(my_country_elev), 
    expand = FALSE
  ) +
  theme_minimal() +
  theme(
    axis.title = element_blank(),
    plot.title = element_text(hjust = 0.5, face = "bold")
  )

print(my_country_map)
print("Map created.")

# Step 5: Optional Save
# ggsave(
#   "my_country_dem.png", plot = my_country_map, width = 8,
#   height = 6, dpi = 300, bg = "white")
# print("Map potentially saved.")

# Cleanup (optional)
# rm(elev_df) # Remove potentially large data frame
# gc()        # Suggest garbage collection