#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd


# In[2]:


import numpy as np


# In[29]:


# Read in the client demographics data
client_read_df = pd.read_csv(
    "https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project2_2019/CLIENT_191102.tsv",      # relative python path to subdirectory
    sep='\t'           # Tab-separated value file.
    #quotechar="'",        # single quote allowed as quote character
    #dtype={"salary": int},             # Parse the salary column as an integer 
    ,usecols=['Client ID', 'Client Age at Entry', 'Client Gender', 'Client Primary Race','Client Ethnicity','Client Veteran Status']   # Only load the three columns specified.
    #parse_dates=['birth_date'],     # Intepret the birth_date column as a date
    #,skiprows=10        # Skip the first 10 rows of the file
 ,na_values=['**']       # Take any '.' or '??' values as NA
,header=0
).drop_duplicates()

client_read_df
#client_total_rows = client_df.count
#print (client_total_rows)


# In[30]:


#Update columns names
client_read_df.columns=['ClientID', 'Age', 'Gender', 'Race','Ethnicity','VeteranStatus']

#client_csv = client_df.to_csv (r'data\client.csv', index = None, header=True) #Don't forget to add '.csv' at the end of the path
client_read_df


# In[100]:


#Update values for better readability
client_read_df = client_read_df.replace(to_replace ="Black or African American (HUD)", value ="Black/African American")
client_read_df = client_read_df.replace(to_replace ="White (HUD)", value ="White")
client_read_df = client_read_df.replace(to_replace ="Non-Hispanic/Non-Latino (HUD)", value ="Non-Hispanic/Non-Latino") 
client_read_df = client_read_df.replace(to_replace ="Asian (HUD)", value ="Asian") 
client_read_df = client_read_df.replace(to_replace ="Native Hawaiian or Other Pacific Islander (HUD)", value ="Native Hawaiian/Pacific Islander") 
client_read_df = client_read_df.replace(to_replace ="Data not collected (HUD)", value ="Unknown") 
client_read_df = client_read_df.replace(to_replace ="Client refused (HUD)", value ="Unknown") 
client_read_df = client_read_df.replace(to_replace ="Client doesn't Know (HUD)", value ="Unknown") 
client_read_df = client_read_df.replace(to_replace ="Hispanic/Latino (HUD)", value ="Hispanic/Latino") 
client_read_df = client_read_df.replace(to_replace ="Yes (HUD)", value ="Yes") 
client_read_df = client_read_df.replace(to_replace ="No (HUD)", value ="No") 

#Convert age to int
#client_read_df['Age'] = client_read_df['Age'].astype(int)

client_read_df


# In[106]:


#Create distinct client list using the max age recorded

client_maxage_df = client_read_df.groupby(['ClientID'], sort=False)['Age'].max()
client_maxage_df


# In[107]:


client_maxage_df = client_maxage_df.to_frame().reset_index()

client_maxage_df.columns = ['ClientID','Age']


# In[108]:


#Append corresponding demographics to distinct patient list

client_df = pd.merge(client_maxage_df, client_read_df, how='left', left_on = ['ClientID','Age'], right_on = ['ClientID','Age'])

client_df


# In[6]:


# Read in the disability data
disability_read_df = pd.read_csv(
    "https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project2_2019/DISABILITY_ENTRY_191102.tsv",     # relative python path to subdirectory
    sep='\t'           # Tab-separated value file.
    #quotechar="'",        # single quote allowed as quote character
    #dtype={"salary": int},             # Parse the salary column as an integer 
    ,usecols=['Client ID', 'Disability Type (Entry)', 'Disability Start Date (Entry)', 'Disability Determination (Entry)']   # Only load the three columns specified.
    #parse_dates=['birth_date'],     # Intepret the birth_date column as a date
    #skiprows=10,         # Skip the first 10 rows of the file
    ,na_values=['**']       # Take any '.' or '??' values as NA
    ,header=0
)

disability_read_df
#disability_total_rows = disability_df.count
#print (disability_total_rows)


# In[7]:


#Update column names
disability_read_df.columns=['ClientID', 'Determination', 'DisabilityType', 'StartDate']

disability_read_df


# In[8]:


#filter down to clients that have atleast 1 disability
disability_Yes_df = disability_read_df[disability_df['Determination'] == 'Yes (HUD)'].drop_duplicates()

disability_Yes_df.head(10)


# In[15]:


#Drop start date and remove duplicates
disability_pivot_df1 = disability_Yes_df[['ClientID','Determination','DisabilityType']].drop_duplicates()

disability_pivot_df1


# In[18]:


#Pivot disability table
disability_pivot_df = disability_pivot_df1.pivot(index = 'ClientID', columns = 'DisabilityType', values = 'Determination').fillna('No (HUD)')

disability_pivot_df


# In[20]:


#Rename columns
disability_pivot_df.columns=['AlcoholAbuse','AlcoholandDrugAbuse','ChronicHealthCondition','Developmental',
                             'DrugAbuse','HIVorAIDS','MentalHealthProblem','Other','Learning','Physical','PhysicalMedical','VisionImpaired']

disability_pivot_df


# In[58]:


#Update values to binary values
disability_pivot_df1 = disability_pivot_df.replace(to_replace ="Yes (HUD)", value ="1") 
disability_pivot_df2 = disability_pivot_df1.replace(to_replace ="No (HUD)", value ="0") 

disability_pivot_df2


# In[73]:


#convert to integer fields

disability_pivot_df2['AlcoholAbuse'] = disability_pivot_df2['AlcoholAbuse'].astype(int)
disability_pivot_df2['AlcoholandDrugAbuse'] = disability_pivot_df2['AlcoholandDrugAbuse'].astype(int)
disability_pivot_df2['ChronicHealthCondition'] = disability_pivot_df2['ChronicHealthCondition'].astype(int)
disability_pivot_df2['Developmental'] = disability_pivot_df2['Developmental'].astype(int)
disability_pivot_df2['Developmental'] = disability_pivot_df2['Developmental'].astype(int)
disability_pivot_df2['DrugAbuse'] = disability_pivot_df2['DrugAbuse'].astype(int)
disability_pivot_df2['HIVorAIDS'] = disability_pivot_df2['HIVorAIDS'].astype(int)
disability_pivot_df2['MentalHealthProblem'] = disability_pivot_df2['MentalHealthProblem'].astype(int)
disability_pivot_df2['Other'] = disability_pivot_df2['Other'].astype(int)
disability_pivot_df2['Learning'] = disability_pivot_df2['Learning'].astype(int)
disability_pivot_df2['Physical'] = disability_pivot_df2['Physical'].astype(int)
disability_pivot_df2['PhysicalMedical'] = disability_pivot_df2['PhysicalMedical'].astype(int)
disability_pivot_df2['VisionImpaired'] = disability_pivot_df2['VisionImpaired'].astype(int)

print (disability_pivot_df2.dtypes)


# In[88]:


#Sum the number of disabilities

#clear DisabilityTypeTotal before running the sum
disability_pivot_df2['DisabilityTypeTotal'] = 0
disability_pivot_df2['DisabilityTypeTotal'] = disability_pivot_df2.sum(axis = 1)

disability_df = disability_pivot_df2

disability_df


# In[92]:


disability_csv = disability_df.to_csv (r'data\disability.csv', index = "ClientID", header=True) #Don't forget to add '.csv' at the end of the path
#disability_read_csv = disability_Yes_df.to_csv (r'data\disability_orig.csv', index = "ClientID", header=True) #Don't forget to add '.csv' at the end of the path


# In[93]:


#Join demographics and disabilities data to create final dataset

master_df = client_df.join(disability_df, how='left', lsuffix='_demo',rsuffix='_dis')

master_df


# In[94]:


master_csv = master_df.to_csv (r'data\master.csv', index = None, header=True) #Don't forget to add '.csv' at the end of the path

