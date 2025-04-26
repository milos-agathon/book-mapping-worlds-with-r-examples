# --- Script: chapter_8_get_data.R ---
# (Can be in same script)

# Step 1: Define country code
country_iso <- "CHE" # ISO 3166-1 alpha-3 code for Switzerland
print(paste("Fetching elevation data for:", country_iso))

# Step 2: Download/Load elevation data using geodata::elevation_30s
# This gets SRTM 30-arc-second data (~1km resolution)
# path = tempdir() saves download temporarily

swiss_elev_raster <- geodata::elevation_30s(
  country = country_iso, path = tempdir())
print("Elevation data downloaded/loaded.")

# Step 3: Inspect the loaded raster object using print()
print("--- Raster Summary ---")
print(swiss_elev_raster)
# Note the CRS (likely WGS84 EPSG:4326) and resolution (approx
# 0.0083 degrees)

# Step 4: Quick plot using terra's built-in plot() function
print("Generating quick plot...")
terra::plot(
  swiss_elev_raster, 
  main = paste("Elevation (SRTM 30s) -", country_iso))
print("Quick plot done.")

# Store for later use
assign(
  "swiss_elev_raster", swiss_elev_raster, 
  envir = .GlobalEnv
)