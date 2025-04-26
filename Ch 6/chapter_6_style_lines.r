# --- Script: chapter_6_style_lines.R ---
# (Can be in same script)

# Step 1: Ensure ggplot2 and data exist
pacman::p_load(ggplot2)

# Step 2: Create the ggplot map
print("Creating styled motorway map...")

styled_motorway_map <- ggplot() +
  # Add the motorway lines using geom_sf
  # Set style attributes OUTSIDE aes() for a fixed style for all motorways
  geom_sf(data = city_motorways_sf,
          color = "darkgoldenrod",
          # Make motorways goldenrod color
          linewidth = 0.6) +       # Set line thickness (use size pre ggplot2 3.4.0)
  
  # Add labels and theme
  labs(
    title = "Motorways in Shenzhen", 
    caption = "Data: OpenStreetMap contributors") +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    # Hide axis text/ticks
    axis.ticks = element_blank(),
    panel.grid = element_blank()
  ) # Hide grid lines

# Step 3: Display the map
print(styled_motorway_map)
