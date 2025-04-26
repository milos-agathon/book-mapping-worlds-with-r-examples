# --- Script: chapter_10_color_3d.R --- 
# (Can be in same script)

# Step 1: Ensure elevation_matrix exists
if (!exists("elevation_matrix")) {
  print(
    "ERROR: 'elevation_matrix' not found. 
      Run data prep step first!")
  stop()
}

# Step 2: Create 3D plot with elevation-based color using 
# height_shade
print("Creating colorized 3D plot using height_shade...")

# Start with the elevation matrix
elevation_matrix |>
  # Create shading based on height, using R's built-in terrain 
  # color palette
  # texture = grDevices::terrain.colors(256) generates 256 colors
  rayshader::height_shade(
    texture = grDevices::terrain.colors(256)) |>
  
  # Pipe this colored texture into plot_3d
  rayshader::plot_3d(
    heightmap = elevation_matrix, # Need heightmap for geometry
    zscale = 10, solid = FALSE, fov = 0, 
    theta = 0, phi = 80, 
    zoom = 0.6, windowsize = c(1000, 800), 
    background = "lightgrey"
  )

print("Colorized 3D plot should appear in RGL window.")
# Remember to close the RGL window manually.
Sys.sleep(2)