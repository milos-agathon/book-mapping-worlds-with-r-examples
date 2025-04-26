# --- Script: chapter_9_save_map.R ---
# (Can be in same script)

# Step 1: Ensure the map object exists and load htmlwidgets
pacman::p_load(htmlwidgets)

# Step 2: Define the output filename (in your project folder)
output_html_file <- "my_interactive_map.html"
print(paste("Saving map to:", output_html_file))

# Step 3: Save the widget using saveWidget()
# First argument is the leaflet map object
# Second argument is the file path/name
# selfcontained = TRUE bundles everything needed into the
# single HTML file
htmlwidgets::saveWidget(
  map_with_layers, file = output_html_file, 
  selfcontained = TRUE)

print("Map saved successfully! Find the HTML file in your project
      folder.")
print("You can double-click the HTML file to open it in your web
      browser.")