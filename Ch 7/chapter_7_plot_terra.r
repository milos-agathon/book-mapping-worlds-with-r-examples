# --- Script: chapter_7_plot_terra.R ---
# (Can be in same script)

# Ensure the raster object exists

# Step 1: Use terra's built-in plot function
# Just pass the SpatRaster object to plot()
print("Generating basic plot using terra::plot()...")
# This opens in the standard R graphics device
# (Plots pane in RStudio)
terra::plot(global_elevation_10min)
print("Basic plot displayed in Plots pane.")