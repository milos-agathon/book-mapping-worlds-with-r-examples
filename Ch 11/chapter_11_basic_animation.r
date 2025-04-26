# --- Script: chapter_11_basic_animation.R --- 
# (Can be in same script)

# Step 1: Ensure gganimate and base plot exist
pacman::p_load(
  gganimate, gifski
)

# Step 2: Add the gganimate transition layer!
print("Adding animation layer...")
animated_map <- base_life_exp_map +  # Start with our static ggplot 
  # object
  
  # Tell gganimate to create frames based on the 'year' column
  gganimate::transition_time(time = year) +
  
  # Add a title that shows the CURRENT year being displayed
  # '{frame_time}' is a special variable provided by transition_time
  # ()
  # It holds the value of the 'time' variable for the current frame.
  labs(
    title = "Life Expectancy in Year: {as.integer(frame_time)}"
  )

# Step 3: "Render" the animation
# Printing the gganimate object starts the rendering process.
# In RStudio, it usually shows progress and displays the animation.
# This can take some time depending on data size and number of 
# frames!
print("Rendering animation (this may take a while)...")

# Render the animation (adjust nframes, fps for speed/smoothness)
# animate() function explicitly renders it with control over 
# parameters
# Lower nframes/fps for faster previews during testing!
# Using gifski_renderer for reliable preview in RStudio Viewer
anim_render <- gganimate::animate(
  animated_map, nframes = 150, fps = 10,
  width=800, height=500,
  renderer = gifski_renderer())

print("Animation rendering complete (check Viewer pane).")
# Display the rendered animation object
print(anim_render)

# Store animation object
assign("animated_map", animated_map, envir = .GlobalEnv)
assign("anim_render", anim_render, envir = .GlobalEnv) # Store 
# rendered gif