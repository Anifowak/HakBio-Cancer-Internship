library(tidyverse)
library(ggplot2)
library(readr)
library(readxl)
library(dplyr)

# Load the dataset 
cholera_data <- read_csv("C:/Users/EUNICE/Desktop/CHOLERA_DATA.csv")

# View the structure of the data
str(cholera_data)

# Check for missing values
summary(cholera_data)

# Replace NAs with 0 for all columns
cholera_data <- cholera_data %>%
  mutate(across(-Countries, ~replace_na(as.numeric(.), 0))) 
# Clean data: remove rows with missing values 
cholera_data_clean <- na.omit(cholera_data)
# Summarize total reported cases per year
# Calculate total reported cholera cases per year
reported_cases_per_year <- cholera_data_clean %>%
  mutate(`Number of reported cases of cholera` = as.numeric(`Number of reported cases of cholera`)) %>%  
  group_by(Year) %>%
  summarise(total_reported_cases = sum(`Number of reported cases of cholera`, na.rm = TRUE))  

# View the summarized data
print(reported_cases_per_year)

# Display results
head(reported_cases_per_year)

# Ensure the number of reported cases is numeric
reported_cases_per_country <- cholera_data_clean %>%
  mutate(`Number of reported cases of cholera` = as.numeric(`Number of reported cases of cholera`)) %>%  
  group_by(Countries) %>%
  summarise(total_reported_cases = sum(`Number of reported cases of cholera`, na.rm = TRUE)) %>%  
  arrange(desc(total_reported_cases)) 

# View the results
print(reported_cases_per_country)

# Display the top 20 affected countries
head(reported_cases_per_country, 20)
# top 20 countries with the most cholera reported cases
top_countries_R <- reported_cases_per_country %>%
  slice_max(order_by = total_reported_cases, n = 20)

# Line plot for total reported cases per year
ggplot(reported_cases_per_year, aes(x = Year, y = total_reported_cases)) +
  geom_line(color = "blue") +
  ggtitle("Global Cholera reported Cases Over Time") +
  xlab("Year") + ylab("Number of reported Cases")

# Bar plot for top affected countries
top_countries_R <- Reported_cases_per_country %>% top_n(20, total_reported_cases)
ggplot(top_countries_R, aes(x = reorder(Countries, total_reported_cases), y = total_reported_cases)) +
  geom_bar(stat = "identity", fill = "red") +
  coord_flip() +
  ggtitle("Top 20 Countries with Most Cholera Reported Cases") +
  xlab("Country") + ylab("Number of Reported Cases")

colnames(reported_cases_per_country)

#TOTAL REPORTED DEATHS
# Summarize total reported death per year
colnames(cholera_data_clean)

reported_death_per_year <- cholera_data_clean %>%
  mutate(`Number of reported deaths from cholera` = as.numeric(`Number of reported deaths from cholera`)) %>%  
  group_by(Year) %>%
  summarise(total_death_cases = sum(`Number of reported deaths from cholera`, na.rm = TRUE))  

# Summarize total reported cases per country
reported_death_per_country <- cholera_data_clean %>%
  group_by(Countries) %>%
  summarise(total_death_cases = sum(`Number of reported deaths from cholera`, na.rm = TRUE)) %>%
  arrange(desc(total_death_cases))

# Display the top 20 affected countries
head(reported_death_per_country, 20)

# top 20 countries with the most cholera reported cases
top_countries_D <- reported_death_per_country %>% 
  top_n(20, total_death_cases)

# Line plot for total reported cases per year
ggplot(reported_death_per_year, aes(x = Year, y = total_death_cases)) +
  geom_line(color = "blue") +
  ggtitle("Global Cholera Reported Death Cases Over Time") +
  xlab("Year") + ylab("Number of death Cases")

# Bar plot for top affected countries
ggplot(top_countries_D, aes(x = reorder(Countries, total_death_cases), y = total_death_cases)) +
  geom_bar(stat = "identity", fill = "red") +
  coord_flip() +
  ggtitle("Top 20 Countries with Most Cholera Reported Death Cases") +
  xlab("Country") + 
  ylab("Number of Cases")

#Calculate average fatality rate per year
# Convert 'Cholera case fatality rate' to numeric and calculate average fatality rate per year
fatality_rate_per_year <- cholera_data_clean %>%
  mutate(`Cholera case fatality rate` = as.numeric(`Cholera case fatality rate`)) %>%  
  group_by(Year) %>%
  summarise(avg_fatality_rate = mean(`Cholera case fatality rate`, na.rm = TRUE))  

#Calculate average fatality rate per country
library(dplyr)

fatality_rate_per_country <- cholera_data_clean %>%
  mutate(`Cholera case fatality rate` = as.numeric(`Cholera case fatality rate`)) %>%
  filter(!is.na(`Cholera case fatality rate`)) %>%  
  group_by(Countries) %>%
  summarise(avg_fatality_rate = mean(`Cholera case fatality rate`, na.rm = TRUE)) %>%
  arrange(desc(avg_fatality_rate))

# Display the top 20 affected countries
head(fatality_rate_per_country, 20)

# top 20 countries with the most cholera reported cases
top_countries_F <- fatality_rate_per_country %>%
  top_n(20, avg_fatality_rate)  

# Line plot for fatality rate
ggplot(fatality_rate_per_year, aes(x = Year, y = avg_fatality_rate)) +
  geom_line(color = "purple") +
  ggtitle("Average Cholera Fatality Rate Over Time") +
  xlab("Year") + ylab("Fatality Rate (%)")

#Bar plot for top affected countries
ggplot(top_countries_F, aes(x = reorder(Countries, avg_fatality_rate), y = avg_fatality_rate)) +
  geom_bar(stat = "identity", fill = "red") +
  coord_flip() +
  ggtitle("Top 20 Countries with Highest Fatality Rate") +
  xlab("Country") + 
  ylab("Average Fatality Rate")

#CHOLERA REPORTED AND DEATH CASES OVER TIME
# Clean and summarize
cholera_summary <- cholera_data_clean %>%
  mutate(
    `Number of reported cases of cholera` = as.numeric(`Number of reported cases of cholera`),
    `Number of reported deaths from cholera` = as.numeric(`Number of reported deaths from cholera`)
  ) %>%
  group_by(Year) %>%
  summarise(
    Total_Reported_Cases = sum(`Number of reported cases of cholera`, na.rm = TRUE),
    Total_Deaths = sum(`Number of reported deaths from cholera`, na.rm = TRUE)
  )

# Plot cholera cases and deaths over time
ggplot(cholera_summary, aes(x = Year)) +
  geom_line(aes(y = Total_Reported_Cases, color = "Cases")) +
  geom_line(aes(y = Total_Deaths, color = "Deaths")) +
  labs(title = "Cholera Reported Death and Cases Over Time", 
       x = "Year", y = "Count") +
  scale_color_manual(values = c("Cases" = "blue", "Deaths" = "red")) +
  theme_minimal()
# Load necessary libraries
library(ggplot2)

#a barchart for total cases and total death on the same graph
library(dplyr)
library(tidyr)

# Reshape the data to long format for all countries
cholera_summary_per_country <- cholera_data_clean %>%
  group_by(Countries) %>%
  summarise(
    total_cases = sum(`Number of reported cases of cholera`, na.rm = TRUE),
    total_deaths = sum(`Number of reported deaths from cholera`, na.rm = TRUE)
  ) %>%
  arrange(desc(total_cases))


library(dplyr)
library(tidyr)
library(ggplot2)

# Reshape the data to long format
cholera_long_all <- cholera_summary_per_country %>%
  pivot_longer(cols = c(total_cases, total_deaths),  
               names_to = "Metric", 
               values_to = "Count") %>%
  mutate(Metric = factor(Metric, levels = c("total_cases", "total_deaths")))  

# Create the side-by-side bar chart for all countries
ggplot(cholera_long_all, aes(x = reorder(Countries, -Count), y = Count, fill = Metric)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8)) +  
  coord_flip() +  Top
  labs(title = "Reported Cholera Cases and Deaths by Country",
       x = "Country",
       y = "Count",
       fill = "Metric") +
  scale_fill_manual(values = c("total_cases" = "blue", "total_deaths" = "red"), 
                    labels = c("Total Cases", "Total Deaths")) +  
  theme_minimal() +
  theme(axis.text.y = element_text(size = 10))

# data FOR top 20 countries by total REPORTED AND DEATH cases
cholera_summary_top20 <- cholera_data_clean %>%
  group_by(Countries) %>%
  summarise(
    total_cases = sum(`Number of reported cases of cholera`, na.rm = TRUE),
    total_deaths = sum(`Number of reported deaths from cholera`, na.rm = TRUE)
  ) %>%
  arrange(desc(total_cases)) %>%   
  top_n(20, total_cases)           

# Create the stacked bar chart for top 20 countries
cholera_long_top20 <- cholera_summary_top20 %>%
  pivot_longer(cols = c(total_cases, total_deaths), 
               names_to = "Metric", 
               values_to = "Count")

# Create a line chart with total cases and deaths
library(ggplot2)

# Create the side-by-side bar chart with correct ordering based on total cases
ggplot(cholera_long_top20, aes(x = reorder(Countries, Count), y = Count, fill = Metric)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8)) +  
  coord_flip() +  
  labs(title = "Top 20 Countries: Reported and Deaths Cholera Cases",
       x = "Country",
       y = "Count",
       fill = "Metric") +
  scale_fill_manual(values = c("total_cases" = "blue", "total_deaths" = "red"), 
                    labels = c("Total Cases", "Total Deaths")) +  
  theme_minimal() +
  theme(axis.text.y = element_text(size = 10))


# Create a bar plot for total cholera cases and deaths for Nigeria

# Check the unique country names in the dataset
unique(cholera_data_clean$Countries)

cholera_Nigeria <- cholera_data_clean %>%
  filter(Countries == "Nigeria") %>%
  mutate(
    `Number of reported cases of cholera` = as.numeric(`Number of reported cases of cholera`),
    `Number of reported deaths from cholera` = as.numeric(`Number of reported deaths from cholera`)
  ) %>%
  group_by(Year) %>%
  summarise(
    Total_Reported_Cases = sum(`Number of reported cases of cholera`, na.rm = TRUE),
    Total_Deaths = sum(`Number of reported deaths from cholera`, na.rm = TRUE)
  )

#CHOLERA REPORTED CASES IN A SPECIFIC COUNTRY OVER TIME
ggplot(cholera_Nigeria, aes(x = Year)) +
  geom_bar(aes(y = Total_Reported_Cases), stat = "identity", fill = "magenta") +
  labs(title = "Cholera Reported Cases in Nigeria Over Time", x = "Year", y = "Number of Cases") +
  theme_minimal()

#cholera reported Cases and Deaths in Nigeria Over Time
ggplot(cholera_Nigeria, aes(x = Year)) +
  geom_line(aes(y = Total_Reported_Cases, color = "Cases")) +
  geom_line(aes(y = Total_Deaths, color = "Deaths")) +
  labs(title = "Cholera Reported_Cases and Deaths in Nigeria Over Time", 
       x = "Year", y = "Count") +
  scale_color_manual(values = c("Cases" = "blue", "Deaths" = "red")) +
  theme_minimal()
library(dplyr)
library(tidyr)
library(ggplot2)

#STACKED BARPLOT FOR NIGERIA
# Step 1: Reshape the data to long format
cholera_long_Nigeria <- cholera_Nigeria %>%
  pivot_longer(cols = c(Total_Reported_Cases, Total_Deaths), 
               names_to = "Metric", 
               values_to = "Count")

# Step 2: Create  stacked bar plot
ggplot(cholera_long_Nigeria, aes(x = Year, y = Count, fill = Metric)) +
  geom_bar(stat = "identity") +  
  labs(title = "Cholera Reported Cases and Deaths in Nigeria Over Time", 
       x = "Year", 
       y = "Count") +
  scale_fill_manual(values = c("Total_Reported_Cases" = "blue", "Total_Deaths" = "red"), 
                    labels = c("Total Reported Cases", "Total Deaths")) +  
  theme_minimal() +
  theme(axis.text.y = element_text(size = 10), 
        legend.position = "top")  

library(dplyr)
library(tidyr)
library(ggplot2)

#HEATMAP
# Step 1: Calculate the average by year and country
cholera_average <- cholera_data_clean %>%
  group_by(Year, Countries) %>%
  summarise(
    avg_cases = mean(`Number of reported cases of cholera`, na.rm = TRUE),
    avg_deaths = mean(`Number of reported deaths from cholera`, na.rm = TRUE)
  ) %>%
  ungroup()

# Step 2: Reshape the data to long format for heatmap
cholera_long <- cholera_average %>%
  pivot_longer(cols = c(avg_cases, avg_deaths), 
               names_to = "Metric", 
               values_to = "Count")

# Step 3: Create the heatmap
ggplot(cholera_long, aes(x = Year, y = Countries, fill = Count)) +
  geom_tile(color = "white") +  
  scale_fill_viridis_c(option = "plasma", name = "Count") +  
  labs(title = "Average Cholera Cases and Deaths by Year and Country",
       x = "Year",
       y = "Country") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 8))  

#CHOLERA OUTBREAK BY YEAR AND COUNTRY
library(dplyr)
library(tidyr)
library(ggplot2)

# Step 1: Calculate total cases or deaths by year and country
cholera_totals <- cholera_data_clean %>%
  group_by(Year, Countries) %>%
  summarise(
    Total_Cases = sum(`Number of reported cases of cholera`, na.rm = TRUE),
    Total_Deaths = sum(`Number of reported deaths from cholera`, na.rm = TRUE)
  ) %>%
  ungroup()

# Step 2: Reshape the data to long format for the heatmap
cholera_long <- cholera_totals %>%
  pivot_longer(cols = c(Total_Cases, Total_Deaths), 
               names_to = "Metric", 
               values_to = "Count")

# Step 3: Create the heatmap for total cases
ggplot(cholera_long %>% filter(Metric == "Total_Cases"), 
       aes(x = Year, y = Countries, fill = Count)) +
  geom_tile(color = "white") +  # Add white grid lines
  scale_fill_viridis_c(option = "plasma", name = "Total Cases") +  
  labs(title = "Cholera Outbreak by Year and Country",
       x = "Year",
       y = "Country") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 8))  

#HEATMAP CHOLERA DEATH BY YEAR AND COUNTRY
library(dplyr)
library(tidyr)
library(ggplot2)

#Create the heatmap for total death cases
ggplot(cholera_long %>% filter(Metric == "Total_Deaths"), 
       aes(x = Year, y = Countries, fill = Count)) +
  geom_tile(color = "white") +  
  scale_fill_viridis_c(option = "plasma", name = "Total Death Cases") + 
  labs(title = "Cholera Death by Year and Country",
       x = "Year",
       y = "Country") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 8))  

#heatmap of average cholera fatality rate by year and country
library(dplyr)
library(tidyr)
library(ggplot2)

# Step 1: Reshape the data to long format for the heatmap
cholera_long <- cholera_data_clean %>%
  select(Year, Countries, `Cholera case fatality rate`) %>%  
  rename(Avg_Fatality_Rate = `Cholera case fatality rate`) %>%
  pivot_longer(cols = Avg_Fatality_Rate, 
               names_to = "Metric", 
               values_to = "Count")

# Step 2: Create the heatmap for average fatality rate
ggplot(cholera_long, 
       aes(x = Year, y = Countries, fill = Count)) +
  geom_tile(color = "white") +  
  scale_fill_viridis_c(option = "plasma", 
                     name = "Avg Fatality Rate (%)", 
                     breaks = seq(0, max(cholera_long$Count, na.rm = TRUE), by = 50)) +  
  labs(title = "Average Cholera Fatality Rate by Year and Country",
       x = "Year",
       y = "Country") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 8))  

#heatmap of average cholera fatality rate by year and country for top 70 countries

# Step 1: Identify the top 70 countries based on total reported cases
top_70_countries <- cholera_data_clean %>%
  group_by(Countries) %>%
  summarise(Total_Cases = sum(`Number of reported cases of cholera`, na.rm = TRUE)) %>%
  arrange(desc(Total_Cases)) %>%
  slice_head(n = 70) %>%
  pull(Countries)

# Step 2: Filter for the top 70 countries and select relevant columns
cholera_top_70 <- cholera_data_clean %>%
  filter(Countries %in% top_70_countries) %>%
  select(Year, Countries, `Cholera case fatality rate`) %>%
  rename(Avg_Fatality_Rate = `Cholera case fatality rate`)

# Step 3: Reshape the data to long format for the heatmap
cholera_70_long <- cholera_top_70 %>%
  pivot_longer(cols = Avg_Fatality_Rate, 
               names_to = "Metric", 
               values_to = "Count")

# Step 4: Create the heatmap for average fatality rate
ggplot(cholera_70_long, 
       aes(x = Year, y = Countries, fill = Count)) +
  geom_tile(color = "white") +  
  scale_fill_viridis_c(option = "plasma", 
                       name = "Avg Fatality Rate (%)", 
                       breaks = seq(0, max(cholera_long$Count, na.rm = TRUE), by = 20)) +  
  labs(title = "Average Cholera Fatality Rate by Top 70 Countries and Year)",
       x = "Year",
       y = "Country") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 8))  


write.csv(cholera_70_long, "cholera_70_long.csv", row.names = FALSE)
write.csv(cholera_average, file = "cholera_average.csv", row.names = FALSE)
write.csv(cholera_country_summary, file = "cholera_country_summary.csv", row.names = FALSE)
write.csv(cholera_data, file = "cholera_data.csv", row.names = FALSE)
write.csv(cholera_data_clean, file = "cholera_data_clean.csv", row.names = FALSE)
write.csv(cholera_long, file = "cholera_long.csv", row.names = FALSE)
write.csv(cholera_long_all, file = "cholera_long_all.csv", row.names = FALSE)
write.csv(cholera_long_Nigeria, file = "cholera_long_Nigeria.csv", row.names = FALSE)
write.csv(cholera_long_top20, file = "cholera_long_top20.csv", row.names = FALSE)
write.csv(cholera_Nigeria, file = "cholera_Nigeria.csv", row.names = FALSE)
write.csv(cholera_summary, file = "cholera_summary.csv", row.names = FALSE)
write.csv(cholera_summary_per_country, file = "cholera_summary_per_country.csv", row.names = FALSE)
write.csv(cholera_summary_top20, file = "cholera_summary_top20.csv", row.names = FALSE)
write.csv(cholera_top_70, file = "cholera_top_70.csv", row.names = FALSE)
write.csv(cholera_totals, file = "cholera_totals.csv", row.names = FALSE)
write.csv(fatality_rate_per_country, "fatality_rate_per_country.csv", row.names = FALSE)
write.csv(fatality_rate_per_year, "fatality_rate_per_year.csv", row.names = FALSE)
write.csv(reported_cases_per_country, "reported_cases_per_country.csv", row.names = FALSE)
write.csv(reported_cases_per_year, "reported_cases_per_year.csv", row.names = FALSE)
write.csv(reported_death_per_country, "reported_death_per_country.csv", row.names = FALSE)
write.csv(reported_death_per_year, "reported_death_per_year.csv", row.names = FALSE)
write.csv(top_countries_D, "top_countries_D.csv", row.names = FALSE)
write.csv(top_countries_F, "top_countries_F.csv", row.names = FALSE)
write.csv(top_countries_R, "top_countries_R.csv", row.names = FALSE)
write.csv(top_70_countries, file = "top_70_countries.csv", row.names = FALSE)













