#:# libraries
library(digest)
library(OpenML)
library(mlr)


#:# config
set.seed(1)

#:# data
data <- getOMLDataSet(data.id = 1461L)
bank <- data$data
head(bank)

#:# preprocessing
head(df)

#:# model
classif_task = makeClassifTask(id = "task", data = bank, target = "Class")
classif_lrn = makeLearner("classif.kknn", predict.type = "prob")

#:# hash 
#:# 3067cfb5d81c84c8bb60176c9de06d3d
hash <- digest(list(classif_task, classif_lrn))
hash

#:# audit
cv <- makeResampleDesc("CV", iters = 5)
r <- resample(classif_lrn, classif_task, cv, measures = list(acc, auc, tnr, tpr, ppv, f1))
r$aggr


#:# session info
sink(paste0("sessionInfo.txt"))
sessionInfo()
sink()