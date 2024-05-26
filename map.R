# Download libraries
library(ggplot2)
library(dplyr)
library(sf)

# Read in data
data <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")
states <- read.csv("/Users/Abby/cs/info201/a4-incarceration-assignment-abigailaiyun/states.csv")

# Map of total number of incarcerated people per state
map <- read_sf(
  "/Users/Abby/cs/info201/a4-incarceration-assignment-abigailaiyun/lower-48-united-states-with-state-boundaries_715.geojson"
)

# Make a new data frame containing the state, average prison population, and
# state coordinates
population <- data %>% 
  left_join(states, by = c("state" = "Abbreviation")) %>% 
  left_join(map, by = c("State" = "name")) %>%
  group_by(State) %>% 
  summarise(
    avg_state_pop = mean(total_pop, na.rm = TRUE),
    geometry = first(geometry)
  ) %>%
  ungroup()

# Plot visually on map
ggplot(population) +
  geom_sf(aes(geometry = geometry, fill = avg_state_pop/1000)) +
  labs(fill = "Population\n(thousand)") +
  ggtitle("Number of Imprisoned Persons Per State") +
  theme_minimal()
