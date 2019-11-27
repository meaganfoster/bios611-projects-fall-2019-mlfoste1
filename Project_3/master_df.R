library(tidyverse)
library(dplyr)
library(stringr)



#----------------------------------------------------------------------------------------------

#Create dataset-----------------------------------------
#load data file in Durham Count Point in Time Data
master_df = read_csv("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-mlfoste1/master/Project_3/data/master.csv", na = '**')

master_df$n <- as.numeric(master_df$count_)
view(master_df)


#Visuals------------------------------------------------

#Race by year
master_race_yr = ggplot(tally(group_by(Race)),
  aes(x = Race, y = n, fill = Race)) +
  geom_bar(stat="identity") + labs(fill="Race")

master_race_yr

#Total Number Services by Family Size by Year
ggplot(final_PIT_df, aes(x=Year_of_service, y=n, group=Indv_Family)) +
  geom_line(aes(color=Indv_Family)) +
  scale_x_discrete() +
  xlab("Year_of_Service") + 
  ggtitle('Durham PIT - Total Number Services by Family Size by Year')


#visuals

#select distinct clientfilenum and  max family size determined by food provided for

group_UMD_df = final_UMD_df %>%
  group_by(Client_File_Number) %>%
  filter(Food_Provided_for > 0, Food_Provided_for <= 10)  %>%
  summarise(max_Food_Provided_for = max(Food_Provided_for)) %>%
  drop_na(max_Food_Provided_for)

View(group_UMD_df)

#Create groups
group_UMD_df$Family_Size <- cut(group_UMD_df$max_Food_Provided_for, breaks = c(0,1,2,3,4,5,6,7,10), labels=c("Individual","2","3","4","5","6","7","8+"))

group_UMD_df$Indv_Family <- cut(group_UMD_df$max_Food_Provided_for, breaks = c(0,1,10), labels=c("Individual","Family"))


#view(group_UMD_df)

#Counts by Family Size (2007-2016)
ggplot(group_UMD_df, aes(x=Family_Size)) +
  geom_bar(aes(fill=Family_Size)) +
  xlab("Family Size") + 
  ggtitle('Counts by Family Size (2007-2016)')

#Individuals Versus Families (2007-2016)
ggplot(group_UMD_df, aes(x=Indv_Family), group = Indv_Family) +
  geom_bar(aes(fill=Indv_Family)) +
  xlab("Family Size") + 
  ggtitle('Individuals Versus Families (2007-2016)')

#view(group_UMD_df)

#join to original data set to append Date_of_Service

#view by each family size
family_size_group_UMD_df = inner_join(group_UMD_df, final_UMD_df, by = c("Client_File_Number" = "Client_File_Number"), suffix = c(".x", ".y")) %>%
  mutate(Year_of_Service = format(Date_of_service, "%Y")) %>%
  group_by(Family_Size, Year_of_Service) %>%
  summarise(n=n_distinct(Client_File_Number))


view(family_size_group_UMD_df)

#Total Number Services by Family Size by Year
ggplot(family_size_group_UMD_df, aes(x=Year_of_Service, y=n, group=Family_Size)) +
  geom_line(aes(color=Family_Size)) +
  scale_x_discrete() +
  xlab("Year_of_Service") + 
  ylab("Number Serviced") + 
  ggtitle('Total Number Serviced by Family Size by Year')


#view by individual vs family
Indv_Family_group_UMD_df = inner_join(group_UMD_df, final_UMD_df, by = c("Client_File_Number" = "Client_File_Number"), suffix = c(".x", ".y")) %>%
  mutate(Year_of_Service = format(Date_of_service, "%Y")) %>%
  group_by(Indv_Family, Year_of_Service) %>%
  summarise(n=n_distinct(Client_File_Number))

view(Indv_Family_group_UMD_df)

#Individual vs Family by Year
ggplot(Indv_Family_group_UMD_df, aes(x=Year_of_Service, y=n, group=Indv_Family)) +
  geom_line(aes(color=Indv_Family)) +
  scale_x_discrete() +
  xlab("Year_of_Service") +
  ylab("Number Serviced") +
  ggtitle('Individual vs Family by Year')

#---------------------------------------------------------------------------------
#Overlap data

#Number serviced vs number reported
  ggplot(Indv_Family_group_UMD_df, aes(x=Year_of_Service, y=n, group=Indv_Family)) +
    geom_line(size=1.5, aes(color=Indv_Family)) +
    geom_line(data=final_PIT_df, aes(x=Year_of_service, y=n, group=Indv_Family, color=measures)) +
    xlab("Year of Service") +
    ylab("Number Serviced") +
    ggtitle('Number of People Serviced vs Number Reported in Durham PIT Count')

