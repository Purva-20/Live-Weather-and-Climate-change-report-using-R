install.packages("tidyverse")
install.packages("lubridate")
library(tidyverse)
library(lubridate)
weather_data <- read_csv("daily_weather_2020-(1).csv")

head(weather_data)

ggplot(weather_data, aes(x = time)) +
  geom_line(aes(y = temperatureHigh, color = "High Temperature")) +
  geom_line(aes(y = temperatureLow, color = "Low Temperature")) +
  labs(title = "Daily High and Low Temperatures in 2020",
       x = "Date",
       y = "Temperature (°F)",
       color = "Legend") +
  theme_minimal()

ggplot(weather_data, aes(x = time, y = precipIntensity)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Daily Precipitation Intensity in 2020",
       x = "Date",
       y = "Precipitation Intensity (in/hr)") +
  theme_minimal()


# Install and load required packages
install.packages("sf")
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")

library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# Convert the data to an sf object
weather_data_sf <- st_as_sf(weather_data, coords = c("Long", "Lat"), crs = 4326)

# Get the world map data
world <- ne_countries(scale = "medium", returnclass = "sf")

# Plot the spatial data
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = weather_data_sf, aes(color = precipIntensity, 
                                      size = precipIntensity), alpha = 0.7) +
  scale_color_viridis_c() +
  labs(title = "Spatial Map of Precipitation Intensity in 2020",
       x = "Longitude",
       y = "Latitude",
       color = "Precipitation Intensity",
       size = "Precipitation Intensity") +
  theme_minimal()


# Example: Highlighting days with extreme wind gusts
ggplot(weather_data, aes(x = time, y = windGust)) +
  geom_line(color = "red") +
  geom_point(data = weather_data %>% filter(windGust > quantile(windGust, 0.95)), color = "darkred", size = 2) +
  labs(title = "Extreme Wind Gusts in 2020",
       x = "Date",
       y = "Wind Gust (mph)") +
  theme_minimal()

#
ggplot(weather_data, aes(x = temperatureHigh)) +
  geom_histogram(binwidth = 2, fill = "orange", color = "black") +
  labs(title = "Distribution of High Temperatures in 2020",
       x = "Temperature (°F)",
       y = "Frequency") +
  theme_minimal()

#
ggplot(weather_data, aes(x = temperatureHigh, y = humidity)) +
  geom_point(alpha = 0.5, color = "blue") +
  labs(title = "Temperature vs. Humidity",
       x = "High Temperature (°F)",
       y = "Humidity (%)") +
  theme_minimal()

