setwd("/main_dir/lab_working_dir/UKBioBank2024")
library(dplyr)
library(data.table)
library(stringr) 
ctrl <- read.table("10K_euro_unrelated_control_IDs_for_CRC", header = F, sep="")
f41203 <- readRDS("/main_dir/UKBB_project_dir/phenotypes/2017_12_13/dataset/p04_divided_into_chunks/ukb_f41200_to_f41203.rds") ##41202-41203
f41204 <- readRDS("/main_dir/UKBB_project_dir/phenotypes/2017_12_13/dataset/p04_divided_into_chunks/ukb_f41204_to_f90010.rds") ##41204-41205
selfRep <- readRDS("/main_dir/UKBB_project_dir/phenotypes/2017_12_13/dataset/p04_divided_into_chunks/ukb_f6139_to_f20002.rds") ##selfREported 20002
##codes for 41202-41204:
#D12:D120,D121,D122,D123,D124,D125,D126,D127,D128,D129 and K635

##codes for 41203-41205:
#211: 2111,2112,2113,2114,2115,2116,2117,2118,2119 and 5690


##codes for 20002 1460:
selfRep <- selfRep %>%
  filter_at(vars(starts_with("f.20002.")), any_vars(. %in% c(1460)))


selfRep <- selfRep %>%
  select(iid, starts_with("f.20002.")) ##1587

filtered_41203 <- f41203 %>%
  filter_at(vars(starts_with("f.41203.")), any_vars(. %in% c(2111, 2112, 2113, 2114, 2115, 2116, 2117, 2118, 2119, 5690)))

filtered_41203 <- filtered_41203 %>%
  select(iid, starts_with("f.41203.")) ##110

filtered_41204 <- f41204 %>%
  filter_at(vars(starts_with("f.41204.")), any_vars(. %in% c("D12", "D120", "D121", "D122", "D123", "D124", "D125", "D126", "D127", "D128", "D129", "K635")))

filtered_41204 <- filtered_41204 %>%
  select(iid, starts_with("f.41204.")) ##9238

filtered_41202 <- f41203 %>%
  filter_at(vars(starts_with("f.41202.")), any_vars(. %in% c("D12", "D120", "D121", "D122", "D123", "D124", "D125", "D126", "D127", "D128", "D129", "K635")))

filtered_41202 <- filtered_41202 %>%
  select(iid, starts_with("f.41202.")) ##20569

filtered_41205 <- f41204 %>%
  filter_at(vars(starts_with("f.41205.")), any_vars(. %in% c(2111, 2112, 2113, 2114, 2115, 2116, 2117, 2118, 2119, 5690)))

filtered_41205 <- filtered_41205 %>%
  select(iid, starts_with("f.41205.")) ##28


#removing excluded ones:
filtered_control <- as.data.frame(ctrl[!(ctrl$V1 %in% filtered_41202$iid),]) #9677 remained
colnames(filtered_control) [1] <- "iid" 
filtered_control <- as.data.frame(filtered_control[!(filtered_control$iid %in% filtered_41203$iid),]) ##9674 remained
colnames(filtered_control) [1] <- "iid" 
filtered_control <- as.data.frame(filtered_control[!(filtered_control$iid %in% filtered_41204$iid),]) ##9613 remained
colnames(filtered_control) [1] <- "iid" 
filtered_control <- as.data.frame(filtered_control[!(filtered_control$iid %in% filtered_41205$iid),]) ##9612 remained
colnames(filtered_control) [1] <- "iid" 
filtered_control <- as.data.frame(filtered_control[!(filtered_control$iid %in% selfRep$iid),]) ##9602 remained
colnames(filtered_control) [1] <- "iid" 










