# Exploring-Statistical-Analysis-with-R

I’m excited to share a detailed analysis I conducted on a blood pressure-reducing drug study using R language. The study involved 40 patients, with the goal of identifying the optimal drug dose for reducing blood pressure. Throughout this project, I applied core statistical theories to ensure a rigorous analysis. Here’s a breakdown of how I used each technique:

1. Descriptive Statistics 📏
I started by summarizing the data using measures of central tendency and dispersion:

Gender: 60% male, 40% female.
Drug Dose (mg): Ranged from 0 mg to 30 mg.
Blood Pressure Reduction (bp.reduction):
Mean reduction = 15 mmHg
Median = 14.5 mmHg
Standard Deviation (SD) = 3.2 mmHg
These calculations helped me understand the distribution and variation in the key variables.

2. Graphical Analysis 📊
Visualizing the data was essential:

Bar Chart for gender distribution: 24 males and 16 females.
Histograms for drug dose distribution to ensure balanced data.
Scatter Plot of bp.reduction vs. dose showed a clear positive trend: higher doses lead to greater blood pressure reduction.
Boxplots revealed no significant outliers in the bp.reduction and dose variables, confirming the data’s reliability.
3. Outlier Detection 🔍
Using boxplots, I identified potential outliers. The data showed no significant outliers, which ensured the robustness of the analysis.

4. Normality Testing 🧪
For valid statistical testing, I needed to check if the data followed a normal distribution:

Shapiro-Wilk Test for bp.reduction gave a p-value of 0.92, confirming normality.
For dose, the p-value was 0.02, indicating it does not follow a normal distribution. This led me to apply non-parametric tests where needed.
5. Homoscedasticity Testing 🏛️
To ensure equal variances across groups, I used Levene’s Test:

The test for bp.reduction showed no significant difference in variance between males and females (p = 0.23), which met the assumption of homoscedasticity.
6. Hypothesis Testing 🔬
I used t-tests to compare means across different groups:

Dose Comparison:
0 mg group: Mean reduction = 5 mmHg
10 mg group: Mean reduction = 12 mmHg
20 mg group: Mean reduction = 18 mmHg
A t-test between 0 mg and 10 mg showed a significant difference (p = 0.03), while 10 mg vs. 20 mg had an even stronger significance (p < 0.001).
Gender Comparison:
Males (0 mg dose): Mean reduction = 3 mmHg
Females (0 mg dose): Mean reduction = 7 mmHg
A t-test showed a significant difference (p = 0.04) between genders at the 0 mg dose.
7. Linear Regression Modeling 📈
To understand the relationship between dose, gender, and bp.reduction, I built a linear regression model:

Coefficient for dose: 0.5, meaning each 1 mg increase in dose resulted in an average increase of 0.5 mmHg in blood pressure reduction.
Adjusted R-squared = 0.78, indicating that 78% of the variation in bp.reduction is explained by dose and gender.
Key Insights and Conclusions 💡
The 10 mg and 20 mg doses had the most significant effect on reducing blood pressure.
Gender differences emerged at the 0 mg dose, with females showing a greater reduction compared to males.
The linear regression confirmed that both the dose and gender were important factors in predicting blood pressure reduction.
This project allowed me to apply advanced statistical techniques in R and demonstrated how these theories can be used across various industries to drive data-driven decisions. I’m excited to continue working on such impactful analyses in different sectors! 🚀
