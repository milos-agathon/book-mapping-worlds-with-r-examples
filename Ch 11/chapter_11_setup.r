# --- Script: chapter_11_setup.R ---

# Step 1: Load necessary packages using pacman
print("Loading packages for Animation...")
# Ensure pacman is loaded first if needed
if (!requireNamespace(
  "pacman", quietly = TRUE)
) install.packages("pacman")
library(pacman)

# Load our main packages
p_load(
  gganimate,  # The star for animating ggplots
  sf,         # For spatial data
  tidyverse,  # For dplyr, piping etc.
  gapminder,  # Our time series dataset
  rnaturalearth, # For world map boundaries
  countrycode, # For matching country names to ISO codes
  gifski,     # For rendering GIFs
  av          # For rendering MP4s (needs ffmpeg)
)

print("Packages ready for animation!")
print(
  "--- NOTE: Saving MP4 video with 'av' requires external 'ffmpeg' 
  installation. ---")