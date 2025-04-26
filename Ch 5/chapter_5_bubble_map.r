# --- Script: chapter_5_bubble_map.R ---
# (Can be in same script)

# Step 1: Ensure ggplot2 and data exist
pacman::p_load(ggplot2, scales) # Need scales for label formatting
# Step 2: Create the bubble map
print("Creating bubble map (size by population)...")

bubble_map <- ggplot() +
  # Layer 1: World map background
  geom_sf(
    data = world_map_background,
    fill = "grey80",
    color = "white",
    linewidth = 0.1
  ) +
  
  # Layer 2: City points - MAP population to SIZE!
  geom_sf(
    data = cities_sf,
    # Use aes() to map 'pop' column to 'size'
    aes(size = pop),
    color = "dodgerblue",
    # Set a fixed color
    shape = 16,
    # Solid circle
    alpha = 0.6
  ) + # Transparency helps with overlap
  
  # Step 3: Control the size scaling and legend
  # scale_size_area ensures area is proportional to value
  # (better perception)
  scale_size_area(
    name = "Population",
    # Legend title
    max_size = 5,
    # Max bubble size on plot
    labels = scales::label_number(scale = 1e-6, suffix = "M")
  ) + # Format labels (Millions)
  
  # Add title and theme
  labs(
    title = "World Cities Sized by Population (> 1M)", 
    caption = "") +
  theme_minimal() +
  theme(axis.text = element_blank(), legend.position = "bottom")

# Step 4: Display the map
print("Displaying bubble map...")
print(bubble_map)