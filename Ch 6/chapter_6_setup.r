# --- Script: chapter_6_setup.R ---

# Step 1: Load necessary packages
print("Loading packages...")
# Ensure pacman is installed and loaded if you use it
if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")
pacman::p_load(sf, tidyverse, osmdata, ggspatial, patchwork)
# ggspatial for map elements later
# patchwork for combining plots later
print("Packages ready.")