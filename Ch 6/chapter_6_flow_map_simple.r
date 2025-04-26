# --- Script: chapter_6_flow_map_simple.R --- # (Can be in same script)

# Step 1: Load ggplot2
pacman::p_load(ggplot2)

# Step 2: Define start and end points (just coordinates for this example)
origin_x <- 4.86      # Approx. Longitude near Vondelpark West
origin_y <- 52.358    # Approx. Latitude
dest_x <- 4.88        # Approx. Longitude near Vondelpark East
dest_y <- 52.36

# Step 3: Create a data frame for the flow segment
# geom_segment needs x, y (start) and xend, yend (end) coordinates
flow_data <- data.frame(
  x_start = origin_x,
  y_start = origin_y,
  x_end = dest_x,
  y_end = dest_y,
  volume = 100 # A fictional flow volume
)
print("Flow segment data created:")
print(flow_data)

# Step 4: Create the plot using geom_segment
print("Creating simple flow map plot...")

# Start ggplot (no base data needed here)
flow_map_simple <- ggplot(data = flow_data) +
  # Add the segment layer
  geom_segment(
    aes(x = x_start, y = y_start, xend = x_end, yend = y_end,
        # Map volume to linewidth (thickness)
        linewidth = volume),
    color = "purple",
    alpha = 0.8,
    # Add an arrowhead
    arrow = arrow(length = unit(0.3, "cm"), type = "closed")
  ) +
  # Control how volume maps to thickness
  scale_linewidth(range = c(0.5, 3), name = "Flow Volume") + # Min/max thickness
  
  # Optional: Add points for origin/destination
  geom_point(aes(x = x_start, y = y_start), color = "darkgreen", size = 3) +
  geom_point(aes(x = x_end, y = y_end), color = "darkred", size = 3) +
  
  # Add labels and theme
  labs(title = "Simple Flow Map Example (Conceptual)") +
  # Use coord_map or coord_sf if plotting on a real map background
  coord_fixed(ratio = 1.6) + # Adjust aspect ratio for pseudo-map look
  theme_minimal()

# Step 5: Display the plot
print(flow_map_simple)