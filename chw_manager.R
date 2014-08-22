
child_visit <- read.csv("Child_Visit 2014-08-04.csv")

pvisit$form.meta.timeEnd <- as.Date(pvisit$form.meta.timeEnd)

#Subsetting based on a date range
july_visits <- pvisit[pvisit$form.meta.timeEnd >= "2014-07-01" & 
                          pvisit$form.meta.timeEnd <= "2014-07-31",]

#####################################################################
#Proportion of Pregnant women receiving on-time routine check-up (every 6 weeks)
#####################################################################
#NUMERATOR
#---------------------------------
pvisit <- read.csv("Pregnancy_Visit 2014-08-11.csv", na.strings = "---")
pvisit$form.meta.timeEnd <- as.Date(pvisit$form.meta.timeEnd)

reportingPeriodEnd <- as.Date("2014-07-31")
#Visits in last 42 days (six weeks)
reportingPeriodStart <- reportingPeriodStart - 42 
last42DaysVisits <- pvisit[pvisit$form.meta.timeEnd >= reportingPeriodStart & 
                               pvisit$form.meta.timeEnd <= reportingPeriodEnd,]

#Retrieve unique visits
last42DaysUniqueVisits <- last42DaysVisits[
    !duplicated(last42DaysVisits$form.case..case_id, fromLast = TRUE),]
totalUniqueVisits <- nrow(last42DaysUniqueVisits)

#DENOMINATOR
case_list <- read.csv("Cases.csv", na.strings = "---")
pregnant_women <- case_list[case_list$type == "pregnancy",]
pregnant_women$closed_on <- as.Date(pregnant_women$closed_on)
#Filter out pregnancies closed before reporting period
#pregnant_women <- pregnant_women[pregnant_women$closed_on <= reportingPeriodStart,]
ended_pregnancies <- pregnant_women[pregnant_women$closed_on <= reportingPeriodStart,]


#Unique entries
july_unique_visits <- 
    july_visits[!duplicated(july_visits$form.case..case_id, fromLast=TRUE),]
unique_pregnancies_count <- nrow(july_unique_visits)


case_list <- read.csv("../case_export_2014_08_11/case_export_2014_08_11/Cases.csv", 
                      na.strings="---")
pregnant_women <- case_list[case_list$type == "pregnancy",]

#case_list$d.edd <- as.Date(case_list$d.edd)
case_list$d.edd <- as.Date(case_list$d.edd, format="%y-%m-%d")

