# --- Script: chapter_10_ggplot_3d.R ---
# (Can be in same script)

# Step 1: Ensure packages and data are ready
pacman::p_load(rayshader, terra, tidyverse)

# Step 2: Create the 2D ggplot map (using elevation color)
# This ggplot object will become the texture for our 3D map.

# Rename layer if needed for aes mapping
names(swiss_elev_raster) <- "elevation"

# Transform raster into data.frame for plotting
swiss_elev_raster_df <- as.data.frame(
  swiss_elev_raster, xy = TRUE, na.rm = TRUE
)

# rayshader doesn't work well with theme_void()
# so we'll define our theme here

theme_for_the_win <- function(){
  theme_minimal() +
    theme(
      axis.line = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      plot.background = element_rect(
        fill = "white", color = NA
      ),
      legend.position = "none"
    )
}

# Use geom_raster for direct plotting
gg_swiss_elev <- ggplot() +
  geom_raster(
    data = swiss_elev_raster_df, 
    aes(x = x, y = y, fill = elevation)) +
  scale_fill_viridis_c(
    option = "mako", name = "") + # Nice Viridis
  theme_for_the_win()

# Step 3: Convert the ggplot to 3D using plot_gg()
print("Converting ggplot to 3D with rayshader...
          (Opens RGL window)")
# plot_gg takes the ggplot object and drapes it onto the
# heightmap matrix
rayshader::plot_gg(
  ggobj = gg_swiss_elev,
  # The ggplot object created above
  multicore = TRUE,
  # Use multiple CPU cores if available
  width = 7,
  height = 7,
  # Width/height ratio for texture
  # render
  scale = 30,
  # Vertical exaggeration (adjust!)
  solid = FALSE,
  # Make the base transparent
  shadow = TRUE,
  # Render shadows based on sun angle
  shadow_darkness = 0.6,
  # How dark the shadows are
  sunangle = 270,
  # Direction sun comes FROM (270=West)
  windowsize = c(1000, 800),
  # RGL window size
  # Camera position arguments
  zoom = 0.5,
  theta = -30,
  # Different angle
  phi = 35 # Different tilt
)

print("3D plot from ggplot should appear in RGL window.")
# Remember to close the RGL window manually.
Sys.sleep(2)