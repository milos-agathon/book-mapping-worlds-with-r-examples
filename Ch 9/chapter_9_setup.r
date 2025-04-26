# --- Script: chapter_9_setup.R ---

# Step 1: Load necessary packages using pacman
print("Loading packages: leaflet, sf, tidyverse...")
# Ensure pacman is loaded first if needed
if (
  !requireNamespace(
    "pacman", quietly = TRUE)
) install.packages("pacman")
library(pacman)

# Load our main packages for this chapter
p_load(leaflet, sf, tidyverse)

print("Packages ready for interactive mapping!")