# Download libraries
library(ggplot2)
library(dplyr)

# Read in data
data <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")

# Get a list of the top 5 largest counties in 2018
top_5_counties <- data %>%
  filter(year == 2018) %>% 
  arrange(desc(total_pop)) %>% 
  head(5) %>% 
  select(county_name)

# Ensure 'county_name' is categorical
data$county_name <- factor(data$county_name, levels = top_5_counties$county_name)

# Ensure 'year' is numerical
data$year <- as.numeric(data$year)
last_5_years <- 2016 : 2011

# Gets the top 5 counties as of 2018 and the data from the last 5 years
top_5_data <- data %>%
  filter(county_name %in% top_5_counties$county_name) %>%
  filter(year %in% last_5_years)

# Create the bar plot with dodged bars and a centered title
ggplot(top_5_data, aes(x = year, y = total_prison_pop, fill = county_name)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Year", y = "Population", 
       title = "Prison Population From 2011 - 2016",
       fill = "County") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"))