---
title: "Project1"
author: "Meagan Foster"
date: "September 25, 2019"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Overview

Data exploration of the "UMD_Services_Provided_20190719.tsv" dataset provided by the Urban Ministry of Durham.  More specifically, an analysis of the trends in services provided to clients per family size.

See ReadMe.md for more information on data sources and project structure.

#Project Plan

--Profile as individuals and families using the food provided for field

--Deduce the number of children in the family by the number of school kits and diapers

--Identify trends based on family size

--Cross reference supplemental datasets 


_Find data on_


--Statistics on impoverished families by family type

----Impact on healthcare

----Needs versus what is being provided


_Literature review_


---Determinants of successful programs such as UMOD for families


##Data Cleaning Steps

* Confirmed duplications did not exist per day due to the client file number merge (via SQLLite)

* Replaced spaces in column names with underscores

* Removed fields unrelated to the scope of this analysis

* Records dropped where Food_Provided_for is NA; Records where Food_Provided_for is greater than 10 or less than 1 were also omitted


```{r echo = FALSE}
spaceless <- function(x) {colnames(x) <- gsub(" ", "_", colnames(x));x}
rename_UMD_df <- spaceless(UMD_df)

select_UMD_df = rename_UMD_df %>%
  select(-'Client_File_Merge', -'Bus_Tickets_(Number_of)', -'Notes_of_Service', -'Referrals', -'Financial_Support', -`Type_of_Bill_Paid`, -`Payer_of_Support`, -'Field1', -'Field2', -'Field3')

dropna_UMD_df = select_UMD_df %>% 
  drop_na(Food_Provided_for)  
      
filter_UMD_df = dropna_UMD_df %>%
  filter(Food_Provided_for > 0, Food_Provided_for <= 10)

final_UMD_df = filter_UMD_df 

str(final_UMD_df)
```

## Including Plots



```{r echo=FALSE}
ggplot(final_UMD_df, aes(x=Food_Provided_for)) +
  stat_count() +
  scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)) +
  xlab("Family Size") + 
  ggtitle('Family Size Distribution')
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
