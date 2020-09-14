# Data Preprocessing Template

# Importing the dataset
dataset = read.csv('Data.csv')

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
training_set[, 1:2] = scale(training_set[, 1:2])
test_set[, 1:2] = scale(test_set[, 1:2])

###########################
dataset$Liked = factor(dataset$Liked, levels = c(0,1))
library(caTools)
set.seed(123)
split = sample.split(dataset$Liked, SplitRatio = 0.8)
training_set = subset(dataset, split = TRUE)
test_set = subset(dataset, split = FALSE)

#install.packages('randomForest')
classifier = randomForest(x= training_set[-692],
                          y= training_set$Liked,
                          ntree = 10)

y_pred = predict(classifier, newdata = test_set[-692])

cm = table(test_set[,692], y_pred)