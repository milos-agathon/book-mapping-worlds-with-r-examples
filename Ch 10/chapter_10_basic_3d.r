# --- Script: chapter_10_basic_3d.R --- 
# (Can be in same script)

# Step 1: Ensure the elevation_matrix exists
if (
  !exists("elevation_matrix")) {
  print(
    "ERROR: 'elevation_matrix' not found. 
      Run data prep step first!")
  stop()
}

# Step 2: Create the basic 3D plot using sphere_shade
print(
  "Creating basic 3D plot... 
  This may open a new window (RGL). Be patient!"
)

# Start with the elevation matrix (our heightmap)
elevation_matrix |>
  # Create a basic spherical shading texture using the built-in 
  # 'desert' palette
  # This calculates shading based only on the shape of the 
  # heightmap matrix
  rayshader::sphere_shade(texture = "desert") |>
  
  # Pipe the shaded texture into plot_3d
  # This function renders the 3D scene in a new window (RGL device)
  rayshader::plot_3d(
    heightmap = elevation_matrix, # Matrix providing elevation 
    # for shape
    zscale = 10, # Vertical exaggeration. TRY 5, 15, 30!
    solid = FALSE, # Make the base transparent
    fov = 0, # Field of view (0=orthographic, good for maps)
    theta = 0, # Rotation angle around Z axis (view FROM)
    phi = 80, # Vertical viewing angle (degrees from horizon)
    zoom = 0.6, # Zoom level (0-1, smaller is closer)
    windowsize = c(1000, 800), # Size of the pop-up window 
    # (width, height)
    background = "lightgrey" # Set background color
  )

# Step 3: Interact with the window!
print(
  "3D plot should appear in a new RGL window."
)
print(
  "Try clicking and dragging in the RGL window to rotate the view!"
)
print("Close the RGL window manually when done viewing.")
# May need rgl::rgl.close() in Console

# Pause briefly to allow window to maybe open fully
Sys.sleep(2)