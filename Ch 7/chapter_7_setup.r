# --- Script: chapter_7_setup.R ---

# Step 1: Load necessary packages using pacman
print("Loading packages: terra, sf, tidyverse, geodata...")
# Ensure pacman is loaded first if needed
if (
  !requireNamespace("pacman", quietly = TRUE)
) install.packages("pacman")
library(pacman)

# Load our main packages
p_load(terra, sf, tidyverse, geodata)

# Step 2: Set theme (optional, for consistent ggplot plots later)
theme_set(theme_minimal())

print("Packages ready for raster action!")