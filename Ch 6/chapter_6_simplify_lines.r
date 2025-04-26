# --- Script: chapter_6_simplify_lines.R --- # (Can be in same script)

# Step 1: Ensure packages and data are ready
pacman::p_load(sf, tidyverse, patchwork) # patchwork for combining plots
# Step 2: Transform paths to a local projected CRS for Shenzhen
# The CGCS2000 / 3-degree Gauss-Kruger zone 38 (EPSG:4526), uses meters.
print("Transforming paths to local projected CRS (EPSG:4526)...")

# Check current CRS first
original_crs <- sf::st_crs(city_motorways_sf)
print(paste("Original CRS:", original_crs$input))

# Transform if not already projected
city_motorways_sf_proj <- city_motorways_sf |> 
  sf::st_transform(crs = 4526)
print("Transformation successful.")

# Proceed only if transformation was successful

# Step 3: Simplify the lines
# Try simplifying details smaller than 5 meters. Adjust tolerance if needed.
tolerance_meters <- 5
print(paste(
  "Simplifying lines with dTolerance =",
  tolerance_meters,
  "meters..."
))

# Apply st_simplify
city_motorways_sf_simplified <- sf::st_simplify(
  city_motorways_sf_proj, dTolerance = tolerance_meters)

print("Simplification complete.")

# Step 4: Plot Original vs Simplified side-by-side using patchwork
print("Plotting comparison...")

# Plot 1: Original (Projected CRS)
plot_original_motorways <- ggplot() +
  geom_sf(data = city_motorways_sf_proj,
          linewidth = 0.5,
          color = "black") +
  labs(title = "Original Paths (Projected)") + theme_void()

# Plot 2: Simplified (Projected CRS)
plot_simplified_motorways <- ggplot() +
  geom_sf(data = city_motorways_sf_simplified,
          linewidth = 0.5,
          color = "blue") +
  labs(
    title = paste(
      "Simplified (", tolerance_meters, "m Tol.)", 
      sep = "")) + 
  theme_void()

# Combine plots using patchwork's '+' operator
comparison_plot_motorways <- plot_original_motorways + plot_simplified_motorways
print(comparison_plot_motorways)