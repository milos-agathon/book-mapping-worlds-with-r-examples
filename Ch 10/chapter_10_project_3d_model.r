# --- Script: chapter_10_project_3d_model.R ---

# Step 1: Choose Region & Setup
print("Loading packages for 3D Model Exercise...")
pacman::p_load(rayshader, terra, geodata, sf, tidyverse)

# --- USER INPUT: SET YOUR REGION HERE ---
# Use ISO code for a country
project_iso_code <- "NZL"
project_region_name <- "New Zealand"

# Step 2: Get Elevation Data
print(paste("Fetching elevation data for", project_region_name))

elevation_raster <- geodata::elevation_30s(
  country = project_iso_code, path = tempdir())

print("Elevation data obtained.")

# Optional Crop (Example: if using ISO for a large country)
# crop_extent <- terra::ext(xmin, xmax, ymin, ymax)
# Define smaller extent
# elevation_raster <- terra::crop(elevation_raster, crop_extent)

# Step 3: Convert to Matrix
print("Converting raster to matrix...")
elevation_matrix <- rayshader::raster_to_matrix(elevation_raster)

print(
  paste(
    "Matrix dimensions:", 
    paste(dim(elevation_matrix), 
          collapse = " x ")
    )
  )

# Step 4: Create Basic 3D Plot
print("Creating initial 3D plot (opens RGL)...")
# Experiment with texture:
# "imhof1", "imhof2", "imhof3", "imhof4", "desert", "bw"
initial_zscale <- 15 # Starting vertical exaggeration
initial_theta <- 0
initial_phi <- 85

elevation_matrix |>
  rayshader::sphere_shade(texture = "imhof1") |>
  rayshader::plot_3d(
    heightmap = elevation_matrix,
    zscale = initial_zscale,
    fov = 0,
    theta = initial_theta,
    phi = initial_phi,
    zoom = 0.7,
    windowsize = c(800, 600)
  )

# Step 5 & 6: Experiment with zscale and Camera
print(paste("Initial plot uses zscale =", initial_zscale))
print(
  "-> Try changing 'initial_zscale' in the code and re-running.")

print(
"-> Or, drag the RGL window view, then run
'rayshader::render_camera()' in Console."
)

# Example: Capture current camera after manual adjustment (run in
# Console)
# current_cam <- rayshader::render_camera()
# print(current_cam)

# Step 7: Save Snapshot
print("Saving snapshot of the current RGL view...")
snapshot_filename <- paste0(
  project_iso_code, "_3d_snapshot.png")

rayshader::render_snapshot(
  filename = snapshot_filename,
  title_text = paste(
    project_region_name, "(3D Snapshot)"),
  title_bar_color = "black",
  title_color = "white"
)
print(paste("Snapshot saved to", snapshot_filename))

# Step 8: High Quality Render
print("Starting high quality render (takes time)...")

hq_filename <- paste0(project_iso_code, "_3d_hq.png")
rayshader::render_highquality(
  filename = hq_filename,
  lightdirection = 290,
  lightaltitude = 60,
  lightintensity = 1000,
  title_text = paste(project_region_name, "(High Quality)"),
  width = 1080,
  height = 1200,
  interactive = FALSE
)
print(paste("High quality render saved to", hq_filename))

# Close RGL window
try(rgl::rgl.close(), silent = TRUE
)