# --- Script: chapter_11_easing.R ---
# (Can be in same script)

# Step 1: Start with the base ggplot (base_life_exp_map)
print("Adding animation layers with easing...")
animated_map_eased <- base_life_exp_map +
  gganimate::transition_time(year) +
  labs(
    title = "Life Expectancy in Year: {as.integer(frame_time)"
  ) +
  # *** ADD Easing function *** # 'sine-in-out' is common
  # choice.
  # Other options: 'linear', 'quadratic-in-out', 'bounce-in',
  # etc.
  gganimate::ease_aes('sine-in-out')

# Step 3: Render the eased animation
print("Rendering eased animation...")
anim_render_eased <- gganimate::animate(
  animated_map_eased,
  nframes = 150,
  fps = 10,
  width = 800,
  height = 500,
  renderer = gifski_renderer()
)
print(anim_render_eased)
print("Eased animation rendering complete.")

# Store eased animation
assign("animated_map_eased", animated_map_eased, envir = .GlobalEnv)