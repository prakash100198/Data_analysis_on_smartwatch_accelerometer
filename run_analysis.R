#assigning for test dataset
test<-read.table("./test/X_test.txt")
View(test)
activity_test<-read.table("./test/y_test.txt")
View(activity_test)
subject_test<-read.table("./test/subject_test.txt")
range(subject_test)
nrow(subject_test)
View(subject_test)

#assigning for train dataset
train<-read.table("./train/X_train.txt")
View(train)
activity_train<-read.table("./train/y_train.txt")
View(activity_train)
subject_train<-read.table("./train/subject_train.txt")
range(subject_train)
nrow(subject_train)

variable_names<-read.table("features.txt")


colnames(test)<-variable_names$V2
View(test)
colnames(train)<-variable_names$V2
View(train)

traintest_clubbed<-rbind(train,test)
View(traintest_clubbed)

activity_clubbed<-rbind(activity_train,activity_test)
colnames(activity_clubbed)<-"activity"
View(activity_clubbed)

subject_clubbed<-rbind(subject_train,subject_test)
colnames(subject_clubbed)<-"subject"
View(subject_clubbed)

activity_test_train<-cbind(activity_clubbed,traintest_clubbed)
View(activity_test_train)



#Q1
finaltesttrain<-cbind(subject_clubbed,activity_test_train)
View(finaltesttrain)

#Q2
mean_sd_final<-finaltesttrain[,grep("[Mm]ean|[sS]td",colnames(finaltesttrain))]
View(mean_sd_final)

#Q3
final_with_activity_name<-ifelse(finaltesttrain$activity==1,"WALKING",ifelse(finaltesttrain$activity==2,"WALKING_UPSTAIRS",ifelse(finaltesttrain$activity==3,"WALKING_DOWNSTAIRS",ifelse(finaltesttrain$activity==4,"SITTING",ifelse(finaltesttrain$activity==5,"STANDING","LAYING")))))
finaltesttrain[,2]=final_with_activity_name
View(finaltesttrain)

tidydata<-cbind(finaltesttrain[,1:2],mean_sd_final)
View(tidydata)
#Q4
names(tidydata)<-gsub("^t","Time",names(tidydata))
names(tidydata)<-gsub("Acc","Accelerometer",names(tidydata))
names(tidydata)<-gsub("-mean()","Mean",names(tidydata))
names(tidydata)<-gsub("-std()","STD",names(tidydata))
names(tidydata)<-gsub("Freq","Frequency",names(tidydata),ignore.case = T)
names(tidydata)<-gsub("BodyBody","Body",names(tidydata),ignore.case = T)
names(tidydata)<-gsub("Gyro","Gyroscope",names(tidydata),ignore.case = T)
names(tidydata)<-gsub("^f","Frequency",names(tidydata))
names(tidydata)<-gsub("angle","Angle",names(tidydata),ignore.case = T)
names(tidydata)<-gsub("gravity","Gravity",names(tidydata),ignore.case = T)
names(tidydata)<-gsub("mag","Magnitude",names(tidydata),ignore.case = T)
names(tidydata)<-gsub("tbody","TimeBody",names(tidydata),ignore.case = T)

str(tidydata)

finaldata<-tidydata%>%group_by(activity,subject)%>%dplyr::summarise_all(list(~mean(.)))
write.table(finaldata,"finaldata.txt",row.names = F)
