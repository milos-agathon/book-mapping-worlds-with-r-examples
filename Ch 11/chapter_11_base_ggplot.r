# --- Script: chapter_11_base_ggplot.R --- 
# (Can be in same script)

# Step 1: Ensure ggplot2 and data exist
pacman::p_load(tidyverse)

# Step 2: Create the base static ggplot
# Use the FULL world_gapminder_sf dataset
# Map the aesthetic (fill) to the variable we want to animate 
# (lifeExp)
print("Creating base ggplot for animation...")

base_life_exp_map <- ggplot(data = world_gapminder_sf) +
  # Use geom_sf, mapping lifeExp to fill color
  geom_sf(
    aes(fill = lifeExp),
    color = "white", # Add a light border
    linewidth = 0.1) + # Thin border
  
  # Use a nice sequential color scale (Magma is good for 
  # low-to-high)
  scale_fill_viridis_c(
    option = "magma", name = "Life Exp.",
    na.value="lightgrey") +
  
  # Use a map-friendly theme
  theme_void() +
  theme(
    legend.position = "bottom",
    legend.key.width = unit(1.5, "cm"),
    plot.title = element_text(hjust = 0.5, size=16, face="bold"), 
    # Title style
    plot.subtitle = element_text(hjust = 0.5, size=14) # Subtitle 
    # style
  )

print("Base ggplot object 'base_life_exp_map' created.")
# print(base_life_exp_map) # Static plot overlays ALL years! Not 
# useful.

# Store base map
assign("base_life_exp_map", base_life_exp_map, envir = .GlobalEnv)