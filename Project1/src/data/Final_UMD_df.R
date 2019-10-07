library(tidyverse)
library(dplyr)


#load data file
UMD_df = read_tsv("https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project1_2019/UMD_Services_Provided_20190719.tsv", na = '**')
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

#Replace spaces in field names with underscores
spaceless <- function(x) {colnames(x) <- gsub(" ", "_", colnames(x));x}
rename_UMD_df <- spaceless(UMD_df)

#Convert date field to date data type; Remove unrelated fields; limit date range to 2006 to 2017 to match open dataset; limit food_provided_for to 1 to 10
final_UMD_df = rename_UMD_df %>%
  mutate(Date_of_service = as.Date(UMD_df$Date, "%m/%d/%Y")) %>%
  select(-'Date', -'Client_File_Merge', -'Bus_Tickets_(Number_of)', -'Notes_of_Service', -'Referrals', -'Financial_Support', -`Type_of_Bill_Paid`, -`Payer_of_Support`, -'Field1', -'Field2', -'Field3') %>%
  subset(Date_of_service > "2005-12-31" & Date_of_service < "2018-01-01")  %>%
  filter(Food_Provided_for > 0, Food_Provided_for <= 10)


#Create groups
group_UMD_df$Family_Size <- cut(group_UMD_df$max_Food_Provided_for, breaks = c(0,1,2,3,4,5,6,7,10), labels=c("Individual","2","3","4","5","6","7","8+"))

group_UMD_df$Indv_Family <- cut(group_UMD_df$max_Food_Provided_for, breaks = c(0,1,10), labels=c("Individual","Family"))


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
#-----------------------------------------------------------
#visuals

#select distinct clientfilenum and  max family size determined by food provided for

group_UMD_df = final_UMD_df %>%
  group_by(Client_File_Number) %>%
  summarise(max_Food_Provided_for = max(Food_Provided_for))
  
#view(group_UMD_df)

#Counts by Family Size (2006-2017)
ggplot(group_UMD_df, aes(x=Family_Size)) +
  geom_bar(aes(fill=Family_Size)) +
  xlab("Family Size") + 
  ggtitle('Counts by Family Size (2006-2017)')

#Individuals Versus Families (2006-2017)
ggplot(group_UMD_df, aes(x=Indv_Family), group = Indv_Family) +
  geom_bar(aes(fill=Indv_Family)) +
  xlab("Family Size") + 
  ggtitle('Individuals Versus Families (2006-2017)')


view(group_UMD_df)

#join to original data set to append Date_of_Service

#view by each family size

family_size_group_UMD_df = inner_join(group_UMD_df, final_UMD_df, by = c("Client_File_Number" = "Client_File_Number"), suffix = c(".x", ".y")) %>%
  mutate(Year_of_Service = format(Date_of_service, "%Y")) %>%
  group_by(Family_Size, Year_of_Service) %>%
  drop_na(Food_Provided_for)  %>%
  count(Family_Size)
  
view(family_size_group_UMD_df)

#Total Number Services by Family Size by Year
ggplot(family_size_group_UMD_df, aes(x=Year_of_Service, y=n, group=Family_Size)) +
  geom_line(aes(color=Family_Size)) +
  xlab("Year_of_Service") + 
  ggtitle('Total Number Services by Family Size by Year')


#view by individual vs family

Indv_Family_group_UMD_df = full_join(group_UMD_df, final_UMD_df, by = c("Client_File_Number" = "Client_File_Number"), suffix = c(".x", ".y")) %>%
  mutate(Year_of_Service = format(Date_of_service, "%Y")) %>%
  group_by(Indv_Family, Year_of_Service) %>%
  count(Indv_Family)

view(Indv_Family_group_UMD_df)

#Individual vs Family by Year
ggplot(Indv_Family_group_UMD_df, aes(x=Year_of_Service, y=n, group=Indv_Family)) +
  geom_area(aes(fill=Indv_Family)) +
  scale_x_discrete() +
  xlab("Year_of_Service") +
  ylab("Number Serviced") +
  ggtitle('Individual vs Family by Year')



