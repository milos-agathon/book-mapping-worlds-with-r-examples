# --- Script: chapter_11_save_animation.R --- 
# (Can be in same script)

# Step 1: Ensure the animation object exists and gifski is loaded
pacman::p_load(gganimate, gifski)
# Let's use 'animated_map_eased' from the previous step

# Step 2: Save the animation using anim_save()
# It needs the animation object created by ggplot + gganimate layers
# OR the object returned by the animate() function. Let's use the 
# ggplot object.
output_filename_gif <- "life_expectancy_animated.gif"

print(
  paste(
    "Saving animation as GIF:", 
    output_filename_gif, "(takes time!)...")
)

# Provide the filename (ending determines format if renderer not 
# specified)
# Provide the animation object (the ggplot object with gganimate 
# layers)
# Adjust width, height, resolution (res), fps, duration/nframes as 
# needed
# Using animate() first and saving its result is also fine.
# Directly saving the ggplot object:
gganimate::anim_save(
  filename = output_filename_gif,
  animation = animated_map_eased, # The ggplot object with 
  # gganimate layers
  nframes = 200, # More frames for smoother final GIF
  fps = 15, # Frames per second
  width = 800, # Width in pixels
  height = 500, # Height in pixels
  res = 100, # Resolution (pixels per inch)
  renderer = gifski_renderer() # Use gifski for good quality GIFs
)
print(
  paste(
    "Animation saved as", 
    output_filename_gif, "in project folder!"
  ))

# Example: Saving as MP4 (if av/ffmpeg work)
# output_filename_mp4 <- "outputs/life_expectancy_animated.mp4"
# print(paste("Saving animation as MP4:", output_filename_mp4, "
# (requires ffmpeg)..."))
# gganimate::anim_save(
#   filename = output_filename_mp4,
#   animation = animated_map_eased,
#   nframes = 300, # Can use more frames for video
#   fps = 30,
#   width = 1280, height = 720, # Standard HD resolution
#   renderer = av_renderer() # Use av package renderer
# )
# print("MP4 potentially saved (check console for errors).")