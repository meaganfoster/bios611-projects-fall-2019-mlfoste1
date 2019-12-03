library(tidyverse)
library(dplyr)
library(stringr)
library(ggplot2)


#load master data file
master_df = read_csv("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-mlfoste1/master/Project_3/data/master.csv", na = 'NaN')


#Create datasets from master data file----------------------------------------------------------------------------------------------

#view(master_df)


#---veteran status by gender

veteranstatus_gender_df = master_df %>%
  filter(VeteranStatus %in% c("Yes (HUD)","No (HUD)")) %>%
  filter(Gender %in% c("Female","Male","Trans Female (MTF or Male to Female)"))
#view(veteranstatus_gender_df)

veteranstatus_gender_plot = ggplot(veteranstatus_gender_df, aes(x = Gender, fill = VeteranStatus)) +
  geom_bar() +
  xlab("Gender") + 
  ylab("Veteran Status")

#veteranstatus_gender_plot

#---veteran status by Race
veteranstatus_race_df = master_df %>%
  filter(VeteranStatus %in% c("Yes (HUD)","No (HUD)")) %>%
  filter(Race %in% c("White (HUD)",
                     "Black or African American (HUD)",
                     "American Indian or Alaska Native (HUD)",
                     "Asian (HUD)",
                     "Native Hawaiian or Other Pacific Islander (HUD)",
                     "Client doesnt know (HUD)",
                     "Data not collected (HUD)",
                     "Client refused (HUD)") 
  )
#veteranstatus_race_df

veteranstatus_race_plot = ggplot(veteranstatus_race_df, aes(x = Race, fill = VeteranStatus)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 55, hjust = 1)) +
  legend("Veteran Status") 
#veteranstatus_race_plot


#---veteran status by Age
veteranstatus_age_df = master_df %>%
  filter(VeteranStatus %in% c("Yes (HUD)","No (HUD)")) %>%
  drop_na(Age)
#veteranstatus_age_df

veteranstatus_age_plot = ggplot(veteranstatus_age_df, aes(x = VeteranStatus, y = Age)) +
  geom_boxplot()
#veteranstatus_age_plot


#---veteran status by disability type
veteranstatus_numberofdisabilities_df = master_df %>%
  filter(VeteranStatus %in% c("Yes (HUD)","No (HUD)"))

#veteranstatus_numberofdisabilities_df

#veteranstatus_numberofdisabilities_plot = ggplot(veteranstatus_numberofdisabilities, aes(x = VeteranStatus, y = TotalNumofDisabilities)) +
#  geom_boxplot()

#master_gather_df = gather(master_df, key = "DisabilityType", value = "YesorNo",
#mclientid,-MaxAge,-Age,-Ethnicity,-Gender,-Race,-ClientID,'AlcoholAbuse(HUD)')

#,'BothAlcoholandDrugAbuse(HUD),ChronicHealthCondition(HUD),Developmental(HUD),DrugAbuse(HUD),HIV/AIDS(HUD),MentalHealthProblem(HUD),Other,Other:Learning,Physical(HUD),Physical/Medical,VisionImpaired,-TotalNumofDisabilities

