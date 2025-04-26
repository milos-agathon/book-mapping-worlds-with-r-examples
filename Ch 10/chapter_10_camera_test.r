# --- Script: chapter_10_camera_test.R ---
# (Can be in same script)
# Example: Re-run plot_gg with different camera angles

print("Plotting with different camera angle (more top-down)...")
rayshader::render_camera(
  zoom = 0.6,
  theta = 0,
  phi = 60
) # Changed theta and phi!

print("--- Now try manually rotating the RGL window! ---")
print("--- Then type 'rayshader::render_camera()' in the
    CONSOLE ---")
# Sys.sleep(10) # Pause to allow interaction