library(tidyverse)
library(dplyr)

data <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")

# Get the county with the largest total population in 2018
county <- data %>% 
  filter(year == 2018) %>% 
  filter(total_pop == max(total_pop, na.rm = TRUE)) %>% 
  pull(county_name)

# Get the population of the county on 2018
population_2018 <- data %>% 
  filter(year == 2018) %>% 
  filter(total_pop == max(total_pop, na.rm = TRUE)) %>% 
  pull(total_pop)

# Get average number imprisoned for this county
average <- data %>% 
  filter(county_name == county) %>% 
  summarise(mean_pop = round(mean(total_prison_pop, na.rm = TRUE))) %>% 
  pull(mean_pop)

# Get greatest proportion of imprisonment for Black Americans based on the 
# total prison population and the population of ages 15 to 64
proportion <- data %>%
  mutate(white = white_prison_pop / white_pop_15to64,
         black = black_prison_pop / black_pop_15to64) %>%
  select(year, white, black) %>% 
  filter_all(all_vars(!is.infinite(.))) %>% 
  filter(black == max(black, na.rm = TRUE))

# Largest imprisoned population state
state <- data %>% 
  filter(total_prison_pop == max(total_prison_pop, na.rm = TRUE)) %>% 
  pull(state)

#Largest prison population 
pop <- data %>%
  filter(total_prison_pop == max(total_prison_pop, na.rm = TRUE)) %>%
  pull(total_prison_pop)




