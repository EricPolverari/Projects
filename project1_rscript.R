setwd("C:/Users/eric/Documents/Clemson University/Fall 2021/Stats/project_1")

LCloans <- read.csv("LCloans2_Q1_2018.csv",header=T)
summary(LCloans$funded_amnt)
summary(LCloans$int_rate)
summary(LCloans$tot_hi_cred_lim)


hist(LCloans$funded_amnt)
hist(LCloans$int_rate)
hist(LCloans$tot_hi_cred_lim)

table(LCloans$funded_amnt)
table(LCloans$int_rate)
hist(LCloans$tot_hi_cred_lim)

sum(is.na(LCloans$funded_amnt))
sum(is.na(LCloans$int_rate))
sum(is.na(LCloans$tot_hi_cred_lim))

plot(LCloans$funded_amnt, LCloans$int_rate)
plot(LCloans$funded_amnt, LCloans$tot_hi_cred_lim)
plot(LCloans$int_rate, LCloans$tot_hi_cred_lim)


cor(LCloans$funded_amnt, LCloans$int_rate)
cor(LCloans$funded_amnt, LCloans$tot_hi_cred_lim)
cor(LCloans$int_rate, LCloans$tot_hi_cred_lim)

barplot(LCloans$funded_amnt, LCloans$int_rate)



sd(LCloans$funded_amnt)
LCloans$home_ownership <- as.factor(LCloans$home_ownership)
tapply(LCloans$funded_amnt, LCloans$home_ownership, mean)
tapply(LCloans$funded_amnt, LCloans$home_ownership, median)
tapply(LCloans$funded_amnt, LCloans$home_ownership, sd)

par(mfrow=c(1,3))
boxplot(LCloans$funded_amnt ~ LCloans$home_ownership, data=LCloans)
boxplot(LCloans$int_rate ~ LCloans$home_ownership, data=LCloans)
boxplot(LCloans$tot_hi_cred_lim ~ LCloans$home_ownership, data=LCloans)

boxplot(LCloans$funded_amnt ~ LCloans$application_type, data=LCloans)
boxplot(LCloans$int_rate ~ LCloans$application_type, data=LCloans)
boxplot(LCloans$tot_hi_cred_lim ~ application_type, data=LCloans)


LCloans$purpose <- as.factor(LCloans$purpose)
proportions(table(LCloans$home_ownership))
proportions(table(LCloans$application_type))

color.names <- c("darkorchid2","darkorange","royalblue1")
plot(LCloans$funded_amnt, LCloans$int_rate,
     col=color.names[LCloans$home_ownership])

boxplot(LCloans$funded_amnt ~ LCloans$application_type, data=LCloans,
       xlab='Home Ownership', ylab='Funded Amount')



