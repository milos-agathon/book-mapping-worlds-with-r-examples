# --- Script: chapter_10_save_output.R ---
# (Can be in same script)

# Step 1: Make sure a 3D plot window (RGL) from plot_3d or plot_gg
# is open.
# If not, re-run one of those commands first to create the scene.
# Arrange the view interactively in the RGL window if desired!
# Example: Ensure the plot_gg window is open
rayshader::plot_gg(
  gg_swiss_elev,
  heightmap = elevation_matrix,
  scale = 30,
  multicore = TRUE,
  windowsize = c(800, 700),
  solid = FALSE,
  shadow = TRUE,
  sunangle = 270,
  zoom = 0.5,
  theta = -30,
  phi = 35
)

# Step 2: Save a quick snapshot of the current view
print("Taking quick snapshot of current RGL view...")
# Create output directory if it doesn't exist
snapshot_file <- "swiss_3d_snapshot.png"
rayshader::render_snapshot(
  filename = snapshot_file,
  # Output filename
  title_text = "Swiss Alps (Snapshot)",
  # Optional title on image
  title_bar_color = "black",
  title_color = "white",
  title_font = "sans",
  vignette = 0.2 # Adds subtle darkening at edges
)
print(paste("Snapshot saved as", snapshot_file))

# Step 3: Render a high-quality image (takes longer!)
print("Rendering high-quality image...
This might take several minutes!")
hq_file <- "swiss_3d_highquality.png"
rayshader::render_highquality(
  filename = hq_file,
  # Name of the output file
  light = TRUE,
  # Turn on simulated lighting (YES!)
  lightdirection = 315,
  # Direction sun comes FROM (e.g., 315=NW)
  lightintensity = 800,
  # Brightness of the main light source
  # (adjust)
  lightaltitude = 45,
  # Angle of the sun above the horizon (degrees)
  interactive = FALSE,
  # Prevent extra preview windows during render
  width = 1200,
  height = 1000,
  # Dimensions of the saved image in pixels
  # Optional: Add title directly to the render
  title_text = "Swiss Alps (High Quality Render)",
  title_offset = c(20, 20),
  # Position from top-left
  title_color = "white",
  title_bar_color = "black"
)
print(
  paste(
    "High-quality image saved as", 
    hq_file, "in your project folder."
    )
  )

# Close the RGL window if you are done
try(rgl::rgl.close(), silent = TRUE
)