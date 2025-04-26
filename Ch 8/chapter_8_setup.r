# --- Script: chapter_8_setup.R ---

# Step 1: Load necessary packages using pacman
print("Loading packages...")
# Ensure pacman is loaded first if needed
if (
  !requireNamespace("pacman", quietly = TRUE)
) install.packages("pacman")
library(pacman)

# Load our main packages
p_load(terra, geodata, sf, tidyverse, viridis) # ggplot2 is part of 
# tidyverse

# Step 2: Set theme (optional, for consistent ggplot plots)
theme_set(theme_minimal())

print("Packages ready!")