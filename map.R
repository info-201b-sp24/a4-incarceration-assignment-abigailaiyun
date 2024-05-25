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
ggplot(map) +
  geom_sf(linewidth = 0.5)

population <- data %>% 
  left_join(states, by = c("state" = "Abbreviation")) %>% 
  left_join(map, by = c("State" = "name")) %>% 
  select(State, total_prison_pop, geometry)

ggplot(population) +
  geom_sf(aes(geometry = geometry, fill = total_prison_pop)) +
  labs(fill = "Population") +
  ggtitle("Number of Imprisoned Persons Per State") +
  theme_minimal()