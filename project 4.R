#0.MyData Reading
MyData <- BloodPressure
str(MyData)
#1.Descriptive statistics
#You can summarize your MyData using summary()
summary(MyData)
MyData$dose=as.numeric(MyData$dose)
MyData$gender=as.numeric(MyData$gender)
MyData$bp.reduction=as.numeric(MyData$bp.reduction)
str(MyData)
summary(MyData)
#same step as summary(MyData) for explaination
#calculating mean, median, minimum, maximum, first and third quartile (for each variable in columns)
#dose
mean(MyData$dose,na.rm=TRUE)
median(MyData$dose,na.rm=TRUE)
min(MyData$dose,na.rm=TRUE)
max(MyData$dose,na.rm=TRUE)
quantile(MyData$dose,na.rm=TRUE,0.25)
quantile(MyData$dose,na.rm=TRUE,0.75)
#bp.reduction
mean(MyData$bp.reduction,na.rm=TRUE)
median(MyData$bp.reduction,na.rm=TRUE)
min(MyData$bp.reduction,na.rm=TRUE)
max(MyData$bp.reduction,na.rm=TRUE)
quantile(MyData$bp.reduction,na.rm=TRUE,0.25)
quantile(MyData$bp.reduction,na.rm=TRUE,0.75)
#gender
mean(MyData$gender,na.rm=TRUE)
median(MyData$gender,na.rm=TRUE)
min(MyData$gender,na.rm=TRUE)
max(MyData$gender,na.rm=TRUE)
quantile(MyData$gender,na.rm=TRUE,0.25)
quantile(MyData$gender,na.rm=TRUE,0.75)
#For the categorical variable existing, calculate a frequency table 
table(MyData$dose)
#0,2,5,10
table(MyData$gender)
#Male and Female
#Calculate thecorrelation coefficient between weights and Heights
# correlation coefficient
cor(MyData$bp.reduction,MyData$dose, use="complete.obs")

#2.Graphics
#Generate a bar chart of a categorical variable for the gender
barplot(table(MyData$gender), xlab="Gender",ylab="Frequency", col = c("red","blue"))
#Generate a bar chart graph with mean bp.reduction in males and females
barplot(tapply(MyData$bp.reduction,list(sex=MyData$gender),mean,na.rm=T),xlab="Gender",ylab="Mean bp.reduction")
#Make a histogram of a continuous variable “dose and bp.reduction”
hist(MyData$dose,xlab="Dose",main="Distribution of Dose")
hist(MyData$bp.reduction,xlab="BP.reduction",main="Distribution of BP.reduction")

#Make a scatter plot of 2 continuous variables Dose and bp.reduction, and add the regression lines for each gender
#install.packages("ggplot2")
library(ggplot2)
ggplot(MyData, aes(x = dose, y = bp.reduction, color = gender)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, aes(group = gender))

#Make a box plot of age  and a separate box plots per Doses (as.factors). 
boxplot(MyData$dose,main="Dose")
boxplot(dose~gender,data=MyData,main="Boxplot per Doses")

#3.Outlier detection
#Explore the data for any existing outliers, identify them (do NOT remove them if found).What do you think?
#we can explore the data using boxplots
#outliers in dose
boxplot(MyData$dose,main="Dose")
length(boxplot.stats(MyData$dose)$out)
#No outliers were found in dose.

#outliers in bp.reduction
boxplot(MyData$bp.reduction,main="Bp.reduction")
length(boxplot.stats(MyData$bp.reduction)$out)
#No outliers were found in bp.reduction.

#outliers in bp.reduction
# Categorical variables do not have outliers
boxplot(MyData$gender,main="Gender")
length(boxplot.stats(MyData$gender)$out)



#4.Testing for normality/ homoscedasticity
#Check the normality using two methods
#dose
qqnorm(MyData$dose)
qqline(MyData$dose)
hist(MyData$dose)
shapiro.test(MyData$dose)#W = 0.82615, p-value = 2.494e-05 
#bp.reduction
qqnorm(MyData$bp.reduction)
qqline(MyData$bp.reduction)
hist(MyData$bp.reduction)
shapiro.test(MyData$bp.reduction)#W = 0.98321, p-value = 0.806 data are likely to come from a normal distribution
#gender
qqnorm(MyData$gender)
qqline(MyData$gender)
hist(MyData$gender)
shapiro.test(MyData$gender)#W = 0.63361, p-value = 9.272e-09 

#Check the homoscedasticity using two methods
library(car)
hist(MyData$bp.reduction, main = "Histogram of bp.reduction")
MyData$gender <- as.factor(MyData$gender)
leveneTest(bp.reduction ~ gender, data = MyData)
boxplot(bp.reduction ~ gender, data= MyData, 
xlab = "gender", ylab = "BP reduction" ,main="Boxplot per gender")



#5.Statistical Inference
#Sample size
# assuming the data is stored in a data frame called 'data'
# with a column named 'Dose' and a column named 'bp.reduction'
t.test(MyData$bp.reduction[MyData$dose == "0"], conf.level = 0.9)
t.test(MyData$bp.reduction[MyData$dose == "0"], conf.level = 0.95)
t.test(MyData$bp.reduction[MyData$dose == "0"], conf.level = 0.99)

t.test(MyData$bp.reduction[MyData$dose == "2"], conf.level = 0.9)
t.test(MyData$bp.reduction[MyData$dose == "2"], conf.level = 0.95)
t.test(MyData$bp.reduction[MyData$dose == "2"], conf.level = 0.99)

t.test(MyData$bp.reduction[MyData$dose == "5"], conf.level = 0.9)
t.test(MyData$bp.reduction[MyData$dose == "5"], conf.level = 0.95)
t.test(MyData$bp.reduction[MyData$dose == "5"], conf.level = 0.99)

t.test(MyData$bp.reduction[MyData$dose == "10"], conf.level = 0.9)
t.test(MyData$bp.reduction[MyData$dose == "10"], conf.level = 0.95)
t.test(MyData$bp.reduction[MyData$dose == "10"], conf.level = 0.99)

#6.Hypothesis testing
#We hypothesis that bp.reduction is different between male vs female (in the group that received placebo, i.e. Dose = 0). Assuming normality and homoscedasticity, can you test this hypothesis using statistical hypothesis framework 
# subset the data to include only participants who received placebo
dose0 <- subset(MyData, dose == 0)
t.test(bp.reduction ~ gender, data = dose0, var.equal = TRUE)
# check normality assumption using a QQ plot and histogram
dose0$gender <- as.factor(dose0$gender)
shapiro.test(dose0[dose0$gender == "0",]$bp.reduction)
shapiro.test(dose0[dose0$gender == "1",]$bp.reduction)
qqnorm(dose0$bp.reduction)
qqline(dose0$bp.reduction)
hist(dose0$bp.reduction)
shapiro.test(dose0$bp.reduction)
# check homogeneity of variance assumption using a box plot
boxplot(bp.reduction ~ gender, data = dose0)
# perform an F-test to formally test homogeneity of variance
var.test(bp.reduction ~ gender, data = dose0)
# subset the data to include only participants who received Dose 0 or 10
#Independence: Each observation in each group is independent of all others.
#Normality: The data in each group are normally distributed.
#Heteroscedasticity: The variances of the two groups are not equal.
dose_0_10 <-subset(MyData, dose == 0 | dose == 10)
str(dose_0_10)
t.test(bp.reduction ~ dose, data = dose_0_10, var.equal = FALSE)
# check normality assumption using a QQ plot and histogram
qqnorm(dose_0_10$bp.reduction[dose_0_10$dose == 0])
qqline(dose_0_10$bp.reduction[dose_0_10$dose == 0])
hist(dose_0_10$bp.reduction[dose_0_10$dose == 0])
qqnorm(dose_0_10$bp.reduction[dose_0_10$dose == 10])
qqline(dose_0_10$bp.reduction[dose_0_10$dose == 10])
hist(dose_0_10$bp.reduction[dose_0_10$dose == 10])

# perform a Shapiro-Wilk test to formally test normality
shapiro.test(dose_0_10$bp.reduction[dose_0_10$dose == 0])
shapiro.test(dose_0_10$bp.reduction[dose_0_10$dose == 10])
# calculate the standard deviations for each group
sd(dose_0_10$bp.reduction[dose_0_10$dose == 0])
sd(dose_0_10$bp.reduction[dose_0_10$dose == 10])
dose_0_10 <- subset(MyData, dose %in% c(0, 10))
var.test(bp.reduction ~ dose, data = dose_0_10)
t.test(bp.reduction ~ dose, data = dose_0_10, var.equal = TRUE)
#equale variance Bec. P-value > 0.05 so we cant reject null hypo
#we will use t-tes as we canot reject homoscad
# Check normality assumption usingQQ plots and histograms for each group:
dose_0_2_5_10 <- subset(MyData, dose %in% c(0, 2, 5, 10))
library(ggplot2)
ggplot(dose_0_2_5_10, aes(x = bp.reduction)) +
  geom_histogram() +
  facet_wrap(~dose) +
  ggtitle("Histogram of Blood Pressure Reduction by Dose")

ggplot(dose_0_2_5_10, aes(sample = bp.reduction)) +
  stat_qq() +
  facet_wrap(~dose) +
  ggtitle("QQ Plot of Blood Pressure Reduction by Dose")
shapiro.test(dose_0_2_5_10$bp.reduction[dose_0_2_5_10$dose == 0])
shapiro.test(dose_0_2_5_10$bp.reduction[dose_0_2_5_10$dose == 2])
shapiro.test(dose_0_2_5_10$bp.reduction[dose_0_2_5_10$dose == 5])
shapiro.test(dose_0_2_5_10$bp.reduction[dose_0_2_5_10$dose == 10])
library(car)
str(dose_0_2_5_10)
dose_0_2_5_10$dose <- as.factor(dose_0_2_5_10$dose)
leveneTest(bp.reduction ~ dose, data = dose_0_2_5_10)
#p-value for Levene's test is greater than 0.05, we can assume homogeneity of variance.
anova_result <- aov(bp.reduction ~ dose, data = dose_0_2_5_10)
summary(anova_result)

TukeyHSD(anova_result)
pairwise.t.test(dose_0_2_5_10$bp.reduction, dose_0_2_5_10$dose,
                p.adjust.method = "bonferroni")


#7.Linear model
library(car)
multiple.regression <- lm(bp.reduction ~ gender + dose, MyData)
summary(multiple.regression)
avPlots(multiple.regression)
simple.regression <- lm(bp.reduction ~  dose, MyData)
confint(simple.regression,level=0.95)


