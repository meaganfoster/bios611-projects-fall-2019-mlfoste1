---
title: "Project1.rmd"
author: "Meagan Foster"
date: "September 25, 2019"
output: html_document
---

```{r echo=FALSE, message=FALSE, warning=FALSE}
library(tidyverse)
```


## Introduction

Data exploration of the "UMD_Services_Provided_20190719.tsv" dataset provided by the Urban Ministry of Durham.  More specifically, an analysis of the trends in services provided to clients per family size.

See ReadMe.md for more information on data sources and project structure.





```{r echo=FALSE, message=FALSE, warning=FALSE}
library(tidyverse)
library(dplyr)


#load data file
UMD_df = read_tsv("https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project1_2019/UMD_Services_Provided_20190719.tsv", na = '**')


#View Data structure

str(UMD_df)

> str(UMD_df)
Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame':	79838 obs. of  18 variables:
  $ Date                   : chr  "1/22/2009" "1/29/2009" "1/20/2009" "11/26/2002" ...
$ Client File Number     : num  212 738 3455 1804 1806 ...
$ Client File Merge      : num  0 0 0 21804 21806 ...
$ Bus Tickets (Number of): num  NA NA NA NA NA NA NA NA NA 10 ...
$ Notes of Service       : chr  "" "" "" "" ...
$ Food Provided for      : num  3 4 6 4 3 NA NA 0 NA NA ...
$ Food Pounds            : num  20 25 40 NA NA NA NA 0 NA NA ...
$ Clothing Items         : num  5 26 39 NA NA NA NA 0 NA NA ...
$ Diapers                : num  NA 12 12 NA NA NA NA NA NA NA ...
$ School Kits            : num  NA NA NA NA NA NA NA NA NA NA ...
$ Hygiene Kits           : num  NA NA NA NA NA NA NA 1 NA NA ...
$ Referrals              : chr  "1" "1" "1" "Baby Love" ...
$ Financial Support      : num  0 0 0 0 0 ...
$ Type of Bill Paid      : chr  "" "" "" "" ...
$ Payer of Support       : chr  "" "" "" "" ...
$ Field1                 : logi  NA NA NA NA NA NA ...
$ Field2                 : logi  NA NA NA NA NA NA ...
$ Field3                 : logi  NA NA NA NA NA NA ...
- attr(*, "problems")=Classes 'tbl_df', 'tbl' and 'data.frame':	2 obs. of  5 variables:
  ..$ row     : int  51529 57939
..$ col     : chr  "Field1" "Field2"
..$ expected: chr  "1/0/T/F/TRUE/FALSE" "1/0/T/F/TRUE/FALSE"
..$ actual  : chr  "`1" "111813"
..$ file    : chr  "'https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project1_2019/UMD_Services_Provided_20190719.tsv'" "'https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project1_2019/UMD_Services_Provided_20190719.tsv'"
- attr(*, "spec")=
  .. cols(
    ..   Date = col_character(),
    ..   `Client File Number` = col_double(),
    ..   `Client File Merge` = col_double(),
    ..   `Bus Tickets (Number of)` = col_double(),
    ..   `Notes of Service` = col_character(),
    ..   `Food Provided for` = col_double(),
    ..   `Food Pounds` = col_double(),
    ..   `Clothing Items` = col_double(),
    ..   Diapers = col_double(),
    ..   `School Kits` = col_double(),
    ..   `Hygiene Kits` = col_double(),
    ..   Referrals = col_character(),
    ..   `Financial Support` = col_double(),
    ..   `Type of Bill Paid` = col_character(),
    ..   `Payer of Support` = col_character(),
    ..   Field1 = col_logical(),
    ..   Field2 = col_logical(),
    ..   Field3 = col_logical()
    .. )


#-------------------------------------------------------------
#Create dataset

spaceless <- function(x) {colnames(x) <- gsub(" ", "_", colnames(x));x}
rename_UMD_df <- spaceless(UMD_df)

select_UMD_df = rename_UMD_df %>%
  select(-'Client_File_Merge', -'Bus_Tickets_(Number_of)', -'Notes_of_Service', -'Referrals', -'Financial_Support', -`Type_of_Bill_Paid`, -`Payer_of_Support`, -'Field1', -'Field2', -'Field3')

dropna_UMD_df = select_UMD_df %>% 
  drop_na(Food_Provided_for)  
      
filter_UMD_df = dropna_UMD_df %>%
  filter(Food_Provided_for > 0, Food_Provided_for <= 10)

final_UMD_df = filter_UMD_df 

#View final Data structure

view(final_UMD_df)

str(final_UMD_df)

Classes 'tbl_df', 'tbl' and 'data.frame':	56345 obs. of  8 variables:
  $ Date              : chr  "1/22/2009" "1/29/2009" "1/20/2009" "11/26/2002" ...
$ Client_File_Number: num  212 738 3455 1804 1806 ...
$ Food_Provided_for : num  3 4 6 4 3 5 1 1 4 4 ...
$ Food_Pounds       : num  20 25 40 NA NA NA NA NA NA NA ...
$ Clothing_Items    : num  5 26 39 NA NA NA NA 0 5 NA ...
$ Diapers           : num  NA 12 12 NA NA NA NA 0 NA NA ...
$ School_Kits       : num  NA NA NA NA NA NA NA 0 NA NA ...
$ Hygiene_Kits      : num  NA NA NA NA NA 1 1 0 NA NA ...
- attr(*, "problems")=Classes 'tbl_df', 'tbl' and 'data.frame':	2 obs. of  5 variables:
  ..$ row     : int  51529 57939
..$ col     : chr  "Field1" "Field2"
..$ expected: chr  "1/0/T/F/TRUE/FALSE" "1/0/T/F/TRUE/FALSE"
..$ actual  : chr  "`1" "111813"
..$ file    : chr  "'https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project1_2019/UMD_Services_Provided_20190719.tsv'" "'https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project1_2019/UMD_Services_Provided_20190719.tsv'"

```

## Results

This chart represents the distribution of family sizes

```{r pressure, echo=FALSE}
#-----------------------------------------------------------
#visuals

ggplot(final_UMD_df, aes(x=Food_Provided_for)) +
  stat_count() +
  scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)) +
  xlab("Family Size") + 
  ggtitle('Family Size Distribution')
```

## Results

This chart (is still in progress.)

```{r pressure, echo=FALSE}
#-----------------------------------------------------------
#visuals

ggplot(final_UMD_df, aes(Food_Provided_for, Food_Pounds)) +
  geom_boxplot() +
  scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)) +
  xlab("Family Size") + 
  ggtitle('Family Size Distribution') 

```

