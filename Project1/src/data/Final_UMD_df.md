---
title: "UMD Clients Serviced Versus Durham County Point-In-Time Survey"
author: "Meagan Foster"
date: "September 25, 2019"
output: html_document
---

  ```{r global, include=FALSE}

library(tidyverse)
library(dplyr)
library(stringr)
UMD_df = read_tsv("https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project1_2019/UMD_Services_Provided_20190719.tsv", na = '**')

spaceless <- function(x) {colnames(x) <- gsub(" ", "_", colnames(x));x}
rename_UMD_df <- spaceless(UMD_df)

final_UMD_df = rename_UMD_df %>%
  mutate(Date_of_service = as.Date(UMD_df$Date, "%m/%d/%Y")) %>%
  select(-'Date', -'Client_File_Merge', -'Bus_Tickets_(Number_of)', -'Notes_of_Service', -'Referrals', -'Financial_Support', -`Type_of_Bill_Paid`, -`Payer_of_Support`, -'Field1', -'Field2', -'Field3') %>%
  subset(Date_of_service > "2006-12-31" & Date_of_service < "2017-01-01") 
  
group_UMD_df = final_UMD_df %>%
  group_by(Client_File_Number) %>%
  filter(Food_Provided_for > 0, Food_Provided_for <= 10)  %>%
  summarise(max_Food_Provided_for = max(Food_Provided_for)) %>%
  drop_na(max_Food_Provided_for)

group_UMD_df$Family_Size <- cut(group_UMD_df$max_Food_Provided_for, breaks = c(0,1,2,3,4,5,6,7,10), labels=c("Individual","2","3","4","5","6","7","8+"))

group_UMD_df$Indv_Family <- cut(group_UMD_df$max_Food_Provided_for, breaks = c(0,1,10), labels=c("Individual","Family"))

family_size_group_UMD_df = inner_join(group_UMD_df, final_UMD_df, by = c("Client_File_Number" = "Client_File_Number"), suffix = c(".x", ".y")) %>%
  mutate(Year_of_Service = format(Date_of_service, "%Y")) %>%
  group_by(Family_Size, Year_of_Service) %>%
  summarise(n=n_distinct(Client_File_Number))
  
Durham_PIT_df = read_csv("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-mlfoste1/master/Project1/data/external/Durham%20County_Homeless_Point%20In%20Time.csv", na = '**')

final_PIT_df = Durham_PIT_df %>%
  select('year','measures','count_') %>%
  filter(measures=="Homeless Individuals" | measures=="Homeless People in Families")

final_PIT_df$Indv_Family<-NA
final_PIT_df$Indv_Family[final_PIT_df$measures=="Homeless Individuals"] <- "Individual"
final_PIT_df$Indv_Family[final_PIT_df$measures=="Homeless People in Families"] <- "Family"
final_PIT_df$Year_of_service <- cut(final_PIT_df$year, breaks = c(2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016), labels=c("2007","2008","2009","2010","2011","2012","2013","2014","2015","2016"))
final_PIT_df$n <- as.numeric(final_PIT_df$count_)

```

## Overview

The "UMD_Services_Provided_20190719.tsv" (UMD) dataset provided by the Urban Ministry of Durham. This data was compared to the Durham County Point-In-Time (PIT) dataset to evaluate the volume of clients serviced by Urban Ministry compared to the number of reported homeless people in Durham county.  

The UMD dataset was reduced to dates of service occurring between 2007 and 2016 to match the date range avaialable in the PIT dataset.  The client data in UMD dataset was then categorized as "Indivual" or "Family".  These data was compared in total service vs reported and totals per year.

Under the U.S. Census Bureau definition, family households consist of two or more individuals who are related by birth, marriage, or adoption, although they also may include other unrelated people. Nonfamily households consist of people who live alone or who share their residence with unrelated individuals.

See ReadMe.md for more information on data sources and project structure.


##UMD Data Summary

  ```{r}
renderPlot({
#Counts by Family Size (2007-2016)
ggplot(group_UMD_df, aes(x=Family_Size)) +
  geom_bar(aes(fill=Family_Size)) +
  xlab("Family Size") + 
  ggtitle('Counts by Family Size (2007-2016)')
})
```


  ```{r}
renderPlot({
#Individuals Versus Families (2007-2016)
ggplot(group_UMD_df, aes(x=Indv_Family), group = Indv_Family) +
  geom_bar(aes(fill=Indv_Family)) +
  xlab("Family Size") + 
  ggtitle('Individuals Versus Families (2007-2016)')
})
```


  ```{r}
renderPlot({
Indv_Family_group_UMD_df = inner_join(group_UMD_df, final_UMD_df, by = c("Client_File_Number" = "Client_File_Number"), suffix = c(".x", ".y")) %>%
  mutate(Year_of_Service = format(Date_of_service, "%Y")) %>%
  group_by(Indv_Family, Year_of_Service) %>%
  summarise(n=n_distinct(Client_File_Number))
})
```


  ```{r}
renderPlot({
#Individual vs Family by Year
ggplot(Indv_Family_group_UMD_df, aes(x=Year_of_Service, y=n, group=Indv_Family)) +
  geom_line(aes(color=Indv_Family)) +
  scale_x_discrete() +
  xlab("Year_of_Service") +
  ylab("Number Serviced") +
  ggtitle('Individual vs Family by Year')
})
```


#PIT Data Summary

  ```{r}
renderPlot({
#Individuals Versus Families (2007-2016)
ggplot(final_PIT_df, aes(x=Indv_Family, y=n)) +
  geom_bar(stat="identity", aes(fill=Indv_Family)) +
  xlab("Family Size") + 
  ggtitle('Durham PIT - Individuals Versus Families (2007-2016)')
})
```

  ```{r}
renderPlot({
#Total Number Services by Family Size by Year
ggplot(final_PIT_df, aes(x=Year_of_service, y=n, group=Indv_Family)) +
  geom_line(aes(color=Indv_Family)) +
  scale_x_discrete() +
  xlab("Year_of_Service") + 
  ggtitle('Durham PIT - Total Number Services by Family Size by Year')
})
```


#UMD vs PIT Data Summary
  ```{r}
renderPlot({
  ggplot(Indv_Family_group_UMD_df, aes(x=Year_of_Service, y=n, group=Indv_Family)) +
    geom_line(size=1.5, aes(color=Indv_Family)) +
    geom_line(data=final_PIT_df, aes(x=Year_of_service, y=n, group=Indv_Family, color=measures)) +
    xlab("Year of Service") +
    ylab("Number Serviced") +
    ggtitle('Number of People Serviced vs Number Reported in Durham PIT Count')})
```

##Conclusion

Conduct a better count nationally. HUD's count should:

.Be nationally coordinated with a more consistent and morerigorous methodology. This and requires appropriate fundinglevels in order to get more useful data.

.Include estimation techniques designed and overseen byexperts in order to quantify the number of homeless individualsthat were missed during the count.

.Include all people experiencing homelessness, includingindividuals that are institutionalized in hospitals and jails orprisons
