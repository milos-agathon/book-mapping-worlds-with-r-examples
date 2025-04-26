# --- Script: chapter_10_setup.R ---

# Step 1: Load necessary packages using pacman
print("Loading packages")
# Ensure pacman is loaded first if needed
if (!requireNamespace(
  "pacman", quietly = TRUE)
) install.packages("pacman")
library(pacman)

# Load our main packages
# This might trigger installation if it's the first time!
p_load(rayshader, terra, geodata, sf, tidyverse)

print("Packages ready for 3D!")
print("--- IMPORTANT: If 'rayshader' loading failed, check 
installation notes! ---")