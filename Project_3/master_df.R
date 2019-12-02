library(tidyverse)
library(dplyr)
library(stringr)


#load master data file
master_df = read_csv("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-mlfoste1/master/Project_3/data/master.csv", na = 'NaN')


#Create datasets to understand veteran demographics----------------------------------------------------------------------------------------------

#---veteran status by gender

veteranstatus_gender_df = master_df %>%
  filter(VeteranStatus %in% c("Yes (HUD)","No (HUD)")) %>%
  filter(Gender %in% c("Female","Male","Trans Female (MTF or Male to Female"))
#veteranstatus_gender_df

veteranstatus_gender_plot = ggplot(veteranstatus_gender_df, aes(x = Gender, fill = VeteranStatus)) +
  geom_bar()
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
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
#veteranstatus_race_plot


#---veteran status by Ethnicity
veteranstatus_ethnicity_df = master_df %>%
  filter(VeteranStatus %in% c("Yes (HUD)","No (HUD)")) %>%
  filter(Ethnicity %in% c("Non-Hispanic/Non-Latino (HUD)",
"Hispanic/Latino (HUD)"
))
#veteranstatus_ethnicity_df

veteranstatus_ethnicity_plot = ggplot(veteranstatus_ethnicity_df, aes(x = Ethnicity, fill = VeteranStatus)) +
  geom_bar()
#veteranstatus_ethnicity_plot


#---veteran status by Age
veteranstatus_age_df = master_df %>%
  filter(VeteranStatus %in% c("Yes (HUD)","No (HUD)")) %>%
 drop_na(Age)
#veteranstatus_age_df

veteranstatus_age_plot = ggplot(veteranstatus_age_df, aes(x = VeteranStatus, y = Age)) +
  geom_boxplot()
#veteranstatus_age_plot

max_Age = master_df %>%
  drop_na(Age) %>%
  summarise(find_max_age = max(Age))
#max_Age

min_Age = master_df %>%
  drop_na(Age) %>%
  summarise(find_min_age = min(Age))
#min_Age






#Create datasets to understand disabilities----------------------------------------------------------------------------------------------

#load master data file
disability_df = read_csv("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-mlfoste1/master/Project_3/data/disability.csv", na = 'NaN')
#disability_df

disability_plot = ggplot(disability_df, aes(x = DisabilityType, fill = DisabilityType)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
  theme_minimal()
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

