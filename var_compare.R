# Download libraries
library(ggplot2)
library(dplyr)

# Read in data
data <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")

# Gets the year and proportion of incarcerated persons to the corresponding 
# population from ages 15 - 64 by racial group
proportion <- data %>%
  mutate(white = white_prison_pop / white_pop_15to64,
         black = black_prison_pop / black_pop_15to64) %>%
  select(year, white, black) %>% 
  filter_all(all_vars(!is.infinite(.)))

# Plots the incarceration proportion by race
ggplot(proportion, aes(proportion = year)) +
  geom_line(aes(x = year, y = black, color = "Black Americans")) +
  geom_line(aes(x = year, y = white, color = "White Americans"), 
            linetype = "dashed") +
  labs(title = "Proportion of Imprisoned Population by Race",
       x = "Year",
       y = "Proportion Incarcerated",
       color = "Racial Group") +
  scale_y_continuous(limits = c(0, 1)) +
  theme_minimal()
