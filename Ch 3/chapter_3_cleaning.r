# --- Script: chapter_3_cleaning.R --- #
# (Can be in the same script file)

# Step 1: Ensure packages and data are ready
print("Loading packages...")
pacman::p_load(sf, dplyr, rnaturalearth) # Need rnaturalearth for continent join example

# Step 2: Select only needed columns
# Let's imagine we only need name, iso code,
# and geometry for our map
# Load world_boundaries.gpkg
world_boundaries_loaded <- sf::st_read("world_boundaries.gpkg")
sf::st_geometry(
  world_boundaries_loaded
) <- "geometry" # name geometry field
print("Selecting specific columns...")
# Use the pipe |> to pass the data through steps
world_selected <- world_boundaries_loaded |>
  # Keep only these columns
  # (adjust names based on your actual data!)
  # Use any_of() to avoid errors if a column doesn't exist
  # Ensure the geometry column is always included when selecting
  dplyr::select(
    dplyr::any_of(
      c("NAME_ENGL", "ISO3_CODE")), geometry)
print("Columns selected:")
print(head(world_selected))

# Step 3: Rename columns for easier use
print("Renaming columns...")
world_renamed <- world_selected |>
  dplyr::rename(
    country_name = NAME_ENGL, # New name = Old name
    iso3 = ISO3_CODE) # Adjust old names based on your data!
# geometry column usually keeps its name)
print("Columns renamed:")
print(head(world_renamed))

# Store the cleaned data (before filtering for Africa)
# for the next step
assign("world_renamed", world_cleaned, envir = .GlobalEnv)

# Step 4: Filter rows - e.g., keep only African countries
# First, we need continent info, which wasn't in our
# simplified gpkg.
# Let's reload the rnaturalearth data which has continents.
print("Reloading rnaturalearth data to get continents for
  filtering example...")
world_ne <- rnaturalearth::ne_countries(
  scale = "medium", returnclass = "sf") |>
  dplyr::select(adm0_a3, continent) |> # Keep ISO and continent
  sf::st_drop_geometry() # We only need the table for joining

# Now join the continent info to our renamed boundaries
world_renamed_with_cont <- world_renamed |>
  dplyr::left_join(world_ne, by = c("iso3" = "adm0_a3"))

print("Filtering for African countries...")

# Filter Africa
africa_only <- world_renamed_with_cont |>
  dplyr::filter(continent == "Africa")
print("Filtered data for Africa:")
print(africa_only) # Show the filtered sf object

# Step 5: Check for and filter out empty/invalid geometries
# (Good Practice!)
print("Checking for/removing empty or invalid geometries...")

# Count initial rows
initial_rows <- nrow(africa_only)

africa_valid_geom <- africa_only |>
  # Remove features where geometry is empty
  dplyr::filter(!sf::st_is_empty(geometry)) |>
  # Optionally, try to fix invalid geometries
  sf::st_make_valid() |>
  # Filter again in case st_make_valid resulted in empty
  # ones
  dplyr::filter(!sf::st_is_empty(geometry))

# Count final rows
final_rows <- nrow(africa_valid_geom)

print(paste("Initial Africa rows:", initial_rows))
print(paste(
  "Rows after removing/fixing empty/invalid
        geometries:",
  final_rows
))