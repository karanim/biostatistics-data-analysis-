# biostatistics-data-analysis-
How to succeed in Data Analysis in Biostatistics 
In this project , I extract data from NHANES website 
Part 1
Abstract
The prevalence of hypertension (High Blood Pressure) due to Alcohol intake is not a new thing, however their exist gap in the study particularly for low levels alcohol consumption and High Blood Pressure. This analysis will develop insights that delve into the both demographical factors and alcohol and hypertension relations, which will build on a foundation for further studies or improvement intervention for public health strategies aimed at combating the high blood pressure in the societies.

Keywords: High Blood Pressure, NHANES, Alcohol:
Introduction 
High blood pressure (BP) stands as a pivotal preventable risk factor for cardiovascular disease, significantly influenced by genetic, environmental and lifestyle factors including die, weight, physical activity, and alcohol consumption. While numerous studies have linked alcohol intake with BO levels, uncertainty surrounds the relationship between alcohol consumption, particularly at or below 2 standard alcoholic drinks per day. This ambiguity may stem from limitations in statistical power or biological distinctions at varying alcohol intake levels. Previous intervention studies predominantly focused on short-term, high-alcohol-intake populations, leaving a gap in understanding the effects of alcohol reduction on BP among the moderate consumers of alcohol. Given the public health significance of the issues of alcohol and increase BP, this study aimed to analyze the association between alcohol consumption and BP, with specific focus to lower levels of alcohol intake. Previous, a meta-analysis study revealed interesting insights showing correlation between chronic alcoholic consumption and hypertension incidence in both genders, with high risk observed in Black individuals compared to Asians or Caucasians, yet mechanistic basis for these differential effects remains elusive. Another study also suggest that alcohol withdrawal can lead to BP reduction; however, the long-term efficacy of interventions targeting BP reduction through alcohol restriction remains uncertain. Additionally, evidence contradicts the notion of a cardio protective effect from low-to-moderate alcohol consumption, challenging the hypothesis that moderate alcohol consumption benefits cardiovascular health, especially considering potential biases related to socioeconomic factors among drinkers.  
Objectives
The study aims to assess the relationship between alcohol consumption and high blood pressure while considering demographic factors such as age, sex, and race. Key point is determining whether alcohol consumption is associated with an increased risk of high blood pressure, and whether this association varies across the different demographic groups.
Null Hypothesis (H0): there is no significant association between alcohol consumption and high blood pressure
Alternative Hypothesis (H1): Alcohol consumption is associated with an increased risk of High BP, either independently or in interaction with demographic factors 
Methods
 The data was handled for preprocessing and transformation and analysis using R version 3.3.0+ , latest release. The libraries used for data manipulation include; haven, tidyverse, car, dyplyr, ROSE, logistf and ggplot2 and others. 
Data was downloaded from NHANES website (Source ), specifically demographic data, alcohol and blood pressure and cholesterol data. The three datasets were loaded into R environment for processing. At first, merging of the data and cleaning to ensure data was ready for analysis. 


Data Preparation
The current analysis is based on the National Health and Nutritional Examination Survey (NHANES) dataset, specifically the demographic component (P_DEMO_XPT), alcohol component (P_ALQ.XPT) and Blood Pressure and Cholesterol (P_BPQ.XPT). All components were merged based on the SEQN (sequence number) of the respondents. From the merged data, six variables were extracted: SEQN, RIDAGEYR, RIAGENDR, RIDRETH1, ALQ121, and BPQ020. 
Part 2 Report 
Data Analysis
After preprocessing, and ensuring data is ready for analysis, the Anderson-Darling Test was employed to evaluate normality of the Blood Pressure and Alcohol intake variables within the cleaned dataset (source ).  Among the statistical test carried out were logistic regression to investigate the association between the prevalence of High Blood Pressure and Alcohol consumption, and other factors such as race, sex and gender.  In this case, High blood pressure was the dependent variable. Initially all the variables were investigated and then alcohol was investigated alone.  Chi-square test was done to determine if there was significant association between High Blood Pressure and Alcohol, the two variables were categorical with yes or no responses and therefore necessary to test (source ). 
Data Visualization
To provide a descriptive view of the interaction of variables in the dataset, ggplot2 libraries in R studio were used to produce pie chart, bar charts and frequency polygon.   



Results
The data was analyzed using R studio and the results are both descriptive and inferential as shown
# Summary statistics for numerical variables
> summary(clean_data[c("age")])
      age       
 Min.   :18.00  
 1st Qu.:34.00  
 Median :50.00  
 Mean   :49.61  
 3rd Qu.:64.00  
 Max.   :80.00  


> table(clean_data$sex)

   1    2 
3835 3668 
> table(clean_data$race)

   1    2    3    4    5 
 895  776 2779 1990 1063 
> table(clean_data$alcoholic)

  No  Yes 
1878 5625 
> table(clean_data$BP)

   0    1 
2808 4695 

> age_group_table            
       
          No  Yes
  0-18     2  125
  19-30  124 1217
  31-40  214  907
  41-50  360  809
  51-60  598  708
  61-70  803  552
  70+    707  377
The minimum age in the NHANE dataset was 18, appropriate for interviewing for health survey in regards to ethical requirements (source). 25% were aged between 18 and 34 years ; median age is 50 years in the dataset. 
 
Prevalence in Age
The chart above shows that High Blood pressure increases with age for instance, those who did not have High blood pressure, the likelihood for contracting BP increases from age 61+ . Those who had high blood pressure, the highest were between (19-30) , (31-40) , this is the age when alcohol intake is higher among the people.  
 
On chart above it demonstrate that the prevalence of High blood pressure was higher amongst the consumer (alcohol) compared to non-consumers. 
 
In respect to gender, the prevalence for among males was 50.4% while that of females was 49.6%


Model with all variables 
> summary(model)

Call:
glm(formula = BP ~ age + sex + race + alcoholic, family = binomial, 
    data = clean_data)

Coefficients:
              Estimate Std. Error z value Pr(>|z|)    
(Intercept)   3.968992   0.165554  23.974  < 2e-16 ***
age          -0.057283   0.001729 -33.134  < 2e-16 ***
sex          -0.007155   0.053220  -0.134    0.893    
race         -0.156236   0.023372  -6.685 2.31e-11 ***
alcoholicYes  0.046280   0.061443   0.753    0.451    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 9921.7  on 7502  degrees of freedom
Residual deviance: 8375.9  on 7498  degrees of freedom
  (8057 observations deleted due to missingness)
AIC: 8385.9

Number of Fisher Scoring iterations: 4
The results summary can be stated as follows:
Intercept which represents the estimated log-odds of having high blood pressure in the model is 3.969 when all other predictors’ variables are estimated to be zero values.  For the variables ( age, as unit increase in age happens, the log-odds of having high blood pressure decreases by 0.057, age is statistically significant given the low p-value (p<0.001).  Sex another variable in our model lacks statistical significance and log-odds of negative value (-0.007) that is not significantly associated with high blood pressure. That means gender has no association with the dependent variable. The race component from our model shows that a unit increase in race, the log-odds of having high blood pressure decreases by 0.156 and there is enough evidence for statistical significance for associating race with high blood pressure given low p-value of (p<0.001) .  Finally, the coefficient for alcoholicYes is 0.046 or 4.6% , but lacks statistical significance given the high p-value (0.451) . The result confirms that there is no significant association between alcohol consumption and high blood pressure when controlling other variables as will be described on the model below
Model with only Alcohol and BP
> # Fit logistic regression model
> model <- glm(BP ~ alcoholic, data = clean_data, family = binomial, maxit = 1000)
> # Summary of the model
> summary(model)

Call:
glm(formula = BP ~ alcoholic, family = binomial, data = clean_data, 
    maxit = 1000)

Coefficients:
             Estimate Std. Error z value Pr(>|z|)    
(Intercept)   0.02556    0.04615   0.554     0.58    
alcoholicYes  0.66279    0.05412  12.247   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 9921.7  on 7502  degrees of freedom
Residual deviance: 9772.2  on 7501  degrees of freedom
AIC: 9776.2

Number of Fisher Scoring iterations: 4

The model intercepts (for individuals not classified as alcoholic) is 2.556% with standard error of 0.04615, the coefficient for the AlcoholicYes variable (indicate individuals who consume alcohol) 0.66279 or 66.279% with standard error of 0.05412.  This means there a higher association between dependent variable and alcohol consumption, further the p-value is less than 0.05 thereby indicating strong association between being classified as alcoholic and pressure.  AIC measure for model goodness of fit is 9776.2, a lower AIC value suggest a batter fitting model however this is not the case for our model.  

Discussion of Findings
The findings suggest that while high blood pressure may be influenced by other factors, age, and race and alcohol consumption have significant influence while gender has little or no impact.  However the exact relationship remains complex
Across different age-groups the prevalence and correlation from the analysis indicates that the likelihood of high blood pressure increases with age, particularly among individuals aged 19-40, a period associated with higher alcohol intake. The observation underscores the need for targeted intervention focusing on younger generation to mitigate the risk of hypertension associated with alcohol consumption. 
Further, the analysis on the association between alcohol consumption and high blood pressure, with the consideration of demographic factors such as race, and sex. While some previous studies have linked hypertension to chronic alcohol consumption, the analysis reveals such a nuanced relationship.  The analysis shows an evidence of higher pressure among people of particular race, however the results fails the statistical significance. For instance age and race shows significant association while blood pressure but lacks the statistical significance.  The findings of this study calls for further review of the variables used on the model to develop more insights so the final model has a better targeted public health strategic intervention.  
Conclusion
In conclusion, the analysis provides valuable insights into the relationship between alcohol consumption and high blood pressure, especially for low alcohol consumers. The influence of demographic factors such as age, gender and race is also important in this model.  The study emphasizes the importance of continued research and analysis of data for possible public health intervention 

 
 
 

