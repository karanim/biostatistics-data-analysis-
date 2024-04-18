library(sas7bdat)
library(tidyverse)
library(lubridate)
library(broom)
library(car)
library(dplyr)
library(nortest)
library(ROSE)
library(dplyr)
library(logistf)
library(ggplot2)
library(knitr)
###########################
 #Data Preparation  #
##############################
# ReadNHANES data
install.packages("haven")  # Install the haven package if not already installed
library(haven)  # Load the haven package into your R session

bp <- read_xpt("E:\\Downloads\\P_BPQ.XPT")
al<- read_xpt("E:\\Downloads\\P_ALQ.XPT")
demog<-read_xpt("E:\\Downloads\\P_DEMO.XPT")

#merging
install.packages("dplyr")  
install.packages("magrittr") 

library(dplyr)  
library(magrittr) 
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}

merged_data <- demog %>%
  left_join(al, by = "SEQN") %>%
  left_join(bp, by = "SEQN")
View(merged_data)
View(al)
#Extract and Recode Variables
# Load the dplyr package
library(dplyr)
# Extract and Recode Variables
clean_data <- merged_data %>%
  select(SEQN, age = RIDAGEYR, sex = RIAGENDR, race = RIDRETH1,
         alcoholic = ALQ121, BP = BPQ020, Gender = RIAGENDR) %>%
  mutate(alcoholic = ifelse(alcoholic > 1, "Yes","No"),
         BP = ifelse(BP > 1, "Yes", "No"))
View(clean_data)

# data preprocessing

clean_data <- na.omit(clean_data)
# Outlier detection and removal (example using z-score)
clean_data <- clean_data %>%
  filter(abs(scale(BP)) < 3)  # Remove rows where BP is more than 3 standard deviations from the mean

# Homogeneity of variance test (example using Levene's test)
leveneTest(BP ~ alcoholic, data = clean_data)





#Analysis Section

# Summary statistics for numerical variables
summary(clean_data[c("age", "sex", "Gender", "race")])

# Frequency table for categorical variables
# Race
race_table <- table(clean_data$race, clean_data$BP)
race_table
# Generate a bar plot for Race
# Bar chart for race
library(ggplot2)
barplot(race_table, beside = TRUE, main = "BP Prevalence by Race", 
        xlab = "race", ylab = "Count", col = c("blue", "red", "green", "yellow", "purple"),
        legend = rownames(race_table))

# Pie chart for gender
pie(gender_table[, "Yes"], labels = rownames(gender_table), 
    main = "BP Prevalence by Gender", col = rainbow(nrow(gender_table)))

# Calculate percentages for BP prevalence by gender
gender_counts <- gender_table[, "Yes"]
total_count <- sum(gender_counts)
percentages <- round((gender_counts / total_count) * 100, 1)

# Create labels with percentages
labels <- paste(rownames(gender_table), ": ", percentages, "%", sep="")

# Plot pie chart with percentages
pie(gender_counts, labels = labels, 
    main = "BP Prevalence by Gender", col = rainbow(nrow(gender_table)))







# Gender
gender_table <- table(clean_data$Gender, clean_data$BP)
gender_table

# Age-groups
# You can create age-groups using the cut() function
clean_data$age <- cut(clean_data$age, breaks = c(0, 18, 30, 40, 50, 60, 70, Inf),
                            labels = c("0-18", "19-30", "31-40", "41-50", "51-60", "61-70", "70+"))
age_group_table <- table(clean_data$age, clean_data$BP)
age_group_table

# Create a histogram for age groups
barplot(age_group_table, beside = TRUE, 
        main = "BP Prevalence by Age Group",
        xlab = "Age Group",
        ylab = "Count",
        col = c("blue", "red", "purple", "green", "gold", "black", "violet"),
        legend = rownames(age_group_table))


# Fit logistic regression model

# Check unique values of BP
# Recode BP variable
clean_data$BP <- ifelse(clean_data$BP == "Yes", 1, 0)

# Fit logistic regression model
model <- glm(BP ~ alcoholic, race,age,  data = clean_data, family = binomial, maxit = 1000)
model

# Summary of the model
summary(model# Contingency table
table_al_bp <- table(clean_data$alcoholic, clean_data$BP)

# Chi-square test
chisq.test(table_al_bp)
# Bar plot
# Load ggplot2 package
library(ggplot2)

# Create the plot
ggplot(clean_data, aes(x = alcoholic, fill = factor(BP))) +
  geom_bar(position = "dodge") +
  labs(title = "Distribution of High Blood Pressure by Alcohol Consumption",
       x = "Alcohol Consumption",
       y = "Count") +
  scale_fill_manual(values = c("No" = "blue", "Yes" = "red")) +  # Set custom colors for No and Yes
  theme_minimal()

glm(formula = BP ~ age + sex + race + alcoholic, family = binomial, 
    data = clean_data)



