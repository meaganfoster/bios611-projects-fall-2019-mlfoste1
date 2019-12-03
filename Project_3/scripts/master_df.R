library(tidyverse)
library(dplyr)
library(stringr)
library(ggplot2)


#load master data file
master_df = read_csv("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-mlfoste1/master/Project_3/data/master.csv", na = 'NaN')


#Create datasets from master data file----------------------------------------------------------------------------------------------

view(master_new_df)


#---veteran status by Age
veteranstatus_numberofdisabilities = master_new_df %>%
  filter(client.VeteranStatus %in% c("Yes (HUD)","No (HUD)"))

#veteranstatus_numberofdisabilities_plot

veteranstatus_numberofdisabilities_plot = ggplot(veteranstatus_numberofdisabilities, aes(x = client.VeteranStatus, y = TotalNumofDisabilities)) +
  geom_boxplot()

master_new_gather_df = gather(master_new_df, key = "DisabilityType", value = "YesorNo",
       mClient.clientid,-MaxAge,-client.Age,-client.Ethnicity,-client.Gender,-client.Race,-ClientID,'AlcoholAbuse(HUD)')

,'BothAlcoholandDrugAbuse(HUD),ChronicHealthCondition(HUD),Developmental(HUD),DrugAbuse(HUD),HIV/AIDS(HUD),MentalHealthProblem(HUD),Other,Other:Learning,Physical(HUD),Physical/Medical,VisionImpaired,-TotalNumofDisabilities

#---veteran status by gender

veteranstatus_gender_df = master_new_df %>%
  filter(client.VeteranStatus %in% c("Yes (HUD)","No (HUD)")) %>%
  filter(client.Gender %in% c("Female","Male","Trans Female (MTF or Male to Female)"))
#view(veteranstatus_gender_df)

veteranstatus_gender_plot = ggplot(veteranstatus_gender_df, aes(x = client.Gender, fill = client.VeteranStatus)) +
  geom_bar() +
  xlab("Gender") + 
  ylab("Veteran Status")

#veteranstatus_gender_plot

#---veteran status by Race
veteranstatus_race_df = master_new_df %>%
  filter(client.VeteranStatus %in% c("Yes (HUD)","No (HUD)")) %>%
  filter(client.Race %in% c("White (HUD)",
                     "Black or African American (HUD)",
                     "American Indian or Alaska Native (HUD)",
                     "Asian (HUD)",
                     "Native Hawaiian or Other Pacific Islander (HUD)",
                     "Client doesnt know (HUD)",
                     "Data not collected (HUD)",
                     "Client refused (HUD)") 
  )
#veteranstatus_race_df

veteranstatus_race_plot = ggplot(veteranstatus_race_df, aes(x = client.Race, fill = client.VeteranStatus)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 55, hjust = 1)) +
  legend("Veteran Status") 
#veteranstatus_race_plot


#---veteran status by Age
veteranstatus_age_df = master_new_df %>%
  filter(client.VeteranStatus %in% c("Yes (HUD)","No (HUD)")) %>%
  drop_na(client.Age)
#veteranstatus_age_df

veteranstatus_age_plot = ggplot(veteranstatus_age_df, aes(x = client.VeteranStatus, y = client.Age)) +
  geom_boxplot()
#veteranstatus_age_plot


#view(disability_df)

disability_plot = ggplot(disability_df, aes(x = DisabilityType)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 35, hjust = 1)) 
#disability_plot

disability_master_df = inner_join(disability_df, master_df, by = c("ClientID" = "ClientID"), suffix = c(".x", ".y")) %>%
  filter(VeteranStatus %in% c("Yes (HUD)","No (HUD)"))
#disability_master_df

disability_master_plot = ggplot(disability_master_df, aes(x = DisabilityType, fill=VeteranStatus)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
#disability_master_plot

disability_veteran_df = inner_join(disability_df, master_df, by = c("ClientID" = "ClientID"), suffix = c(".x", ".y")) %>%
  filter(VeteranStatus %in% c("Yes (HUD)"))
#disability_veteran_df

disability_veteran_plot = ggplot(disability_veteran_df, aes(x = DisabilityType, y=Age)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
#disability_veteran_plot
