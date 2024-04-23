# Biostatistics-data-analysis-
How to succeed in Data Analysis in Biostatistics. The main aim for the project was to conduct logistics regression analysis to ascertain if low intake of alcohol has any correlation with high blood pressure a gap that exist in research that has not yet be undertaken. I used demographical data of the US residents like race, gender, sex ; intake of alcohol in the last 12 months variable and variable indicating whether or not an individual has ever been diagnosised with HBP.   
In this project , I collected  data from NHANES website (extraction) and since the data is available in SAS format, I used import SAS/STATA package in R studio to load the data in my R stuio working directory. Demographic component (P_DEMO_XPT), alcohol component (P_ALQ.XPT) and Blood Pressure and Cholesterol (P_BPQ.XPT). All components were merged based on the SEQN (sequence number) of the respondents. From the merged data, six variables were extracted: SEQN, RIDAGEYR, RIAGENDR, RIDRETH1, ALQ121, and BPQ020. 
# Load libraries  ![image](https://github.com/karanim/biostatistics-data-analysis-/assets/43011591/5b927fb0-020b-44d2-b62b-d377b486b298)
# load datasets and merging ![image](https://github.com/karanim/biostatistics-data-analysis-/assets/43011591/e0025a33-1997-4ff0-8273-77558dccce72)
# cleaning merging variables ![image](https://github.com/karanim/biostatistics-data-analysis-/assets/43011591/3c193759-861d-499f-8a97-88ec42882651)
Rest of steps are on the r file shared

#Output
![image](https://github.com/karanim/biostatistics-data-analysis-/assets/43011591/31301029-5339-4116-9c3f-6cc9fecf7013)
# logistics regression output 
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
# interpretation 
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
