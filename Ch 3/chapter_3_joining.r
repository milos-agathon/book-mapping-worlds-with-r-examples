# --- Script: chapter_3_joining.R ---
# Step 1: Load packages and verify data exists
pacman::p_load(sf, dplyr, readr)

# Step 2: Load the dataset and inspect the key columns
country_indicators_loaded <- readr::read_csv(
  "country_indicators.csv")
print(head(world_renamed$iso3))
print(head(country_indicators_loaded$iso3c))

# Step 3: Perform the left join
world_data_joined <- world_renamed |>
  dplyr::left_join(
    country_indicators_loaded, 
    by = c("iso3" = "iso3c"))

# Step 4: Inspect the result
print("Join complete! Here's a quick glimpse:")
glimpse(world_data_joined)

na_count <- sum(is.na(world_data_joined$population))
print("Number of countries with NA in 'population': ", na_count)