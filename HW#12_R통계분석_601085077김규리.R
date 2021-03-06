#60185077 ��Ը�

install.packages("dplyr")
library(dplyr)
#ad.csv���Ͽ��� ������ �ҷ�����
ds = read.csv("ad.csv")
df = ds %>% select(TV ,radio, newspaper, sales)

summary(df)
pairs(df)

# m1. TV �ܼ� ȸ�� ��
m1 = lm(sales ~ TV, data = df)
summary(m1)
par(mfrow=c(2,2))
plot(m1)

install.packages("interactions")
library (interactions)
interact_plot(df,pred = "sales", modx = "TV", plot.points = TRUE)


# m2. radio �ܼ� ȸ�� ��
m2 = lm(sales ~ radio, data = df)
summary(m2)
par(mfrow=c(2,2))
plot(m2)

# m3. newspaper �ܼ� ȸ�� ��
m3 = lm(sales ~ newspaper, data = df)
summary(m3)
par(mfrow=c(2,2))
plot(m3)

# m4. TV,radio ���� ȸ�� ��
m4 = lm(sales ~ TV + radio, data = df)
summary(m4)
par(mfrow=c(2,2))
plot(m4)

# m5. TV,newspaper ���� ȸ�� ��
m5 = lm(sales ~ TV + newspaper, data = df)
summary(m5)
par(mfrow=c(2,2))
plot(m5)

# m6. radio, newspaper ���� ȸ�� ��
m6 = lm(sales ~ radio + newspaper, data = df)
summary(m6)
par(mfrow=c(2,2))
plot(m6)

# m7. TV, radio, newspaper ���� ȸ�� ��
m7 = lm(sales ~ TV +radio + newspaper, data = df)
summary(m7)
##p���� 0.05���� �����Ƿ� �븳���� ä��
##������ �Ǹŷ��� ����� �����ϴ�.
par(mfrow=c(2,2))
plot(m7)

#m8. 
m8 = lm(sales ~ (TV + radio + newspaper)^2, data = df)
summary(m8)
par(mfrow=c(2,2))
plot(m8)

#training data & testind data
set.seed(100)
trainingRowIndex = sample(1:nrow(df),0.6*nrow(df))
trainingData = df[trainingRowIndex, ]
testData = df[-trainingRowIndex,]

result = lm(sales ~ (TV + radio + newspaper)^2, data = trainingData)

salesPred = predict(result, testData)

actuals_preds=data.frame(cbind(actuals = testData$sales, predict = salesPred))
head(actuals_preds)
correaltion_accuracy = cor(actuals_preds)
correaltion_accuracy