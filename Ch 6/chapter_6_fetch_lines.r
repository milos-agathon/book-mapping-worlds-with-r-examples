# --- Script: chapter_6_fetch_lines.R --- # (Can be in same script)

# Step 1: Get bounding box for Shenzhen, China
# Using a smaller, specific area is key for manageable line queries!
print("Getting bounding box for Shenzhen, China...")

city_bbox <- osmdata::getbb("Shenzhen, China")
print("Bounding box obtained:")
print(city_bbox)

# Step 2: Build and run OSM query for paths within the city
print("Querying OSM for motorways (highway=motorway) in Shenzhen.")
# opq() starts the query for the bounding box. Increase timeout if needed.
# add_osm_feature specifies we want features tagged highway=path
# osmdata_sf() executes the query and returns sf objects
osm_paths_query <- osmdata::opq(bbox = city_bbox, timeout = 60) |>
  osmdata::add_osm_feature(key = "highway", value = "motorway") |>
  osmdata::osmdata_sf() # Execute and get sf objects

print("OSM query complete.")

# Step 3: Extract the lines object
# Path geometries are usually in osm_lines
city_motorways_sf <- osm_paths_query$osm_lines
plot(sf::st_geometry(city_motorways_sf))

assign("city_motorways_sf", city_motorways_sf, envir = .GlobalEnv)