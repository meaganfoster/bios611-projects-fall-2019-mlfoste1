#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd


# In[2]:


import numpy as np


# In[3]:


# Read in the client demographics data
client_df = pd.read_csv(
    "https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project2_2019/CLIENT_191102.tsv",      # relative python path to subdirectory
    sep='\t'           # Tab-separated value file.
    #quotechar="'",        # single quote allowed as quote character
    #dtype={"salary": int},             # Parse the salary column as an integer 
    ,usecols=['Client ID', 'Client Age at Entry', 'Client Gender', 'Client Primary Race','Client Ethnicity','Client Veteran Status']   # Only load the three columns specified.
    #parse_dates=['birth_date'],     # Intepret the birth_date column as a date
    #,skiprows=10        # Skip the first 10 rows of the file
 ,na_values=['**']       # Take any '.' or '??' values as NA
,header=0
)

client_df.head(10)
#client_total_rows = client_df.count
#print (client_total_rows)


# In[4]:


client_df.columns=['ClientID', 'Age', 'Gender', 'Race','Ethnicity','VeteranStatus']

client_csv = client_df.to_csv (r'data\client.csv', index = None, header=True) #Don't forget to add '.csv' at the end of the path
#client_df.head(10)


# In[18]:


# Read in the disability data
disability_df = pd.read_csv(
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

disability_df.head(10)
#disability_total_rows = disability_df.count
#print (disability_total_rows)


# In[19]:


disability_df.columns=['ClientID', 'Determination', 'DisabilityType', 'StartDate']

disability_df.head(10)


# In[21]:


disability_Yes_df = disability_df[disability_df['Determination'] == 'Yes (HUD)'].drop_duplicates()

disability_Yes_df.head(10)


# In[22]:


disability_csv = disability_Yes_df.to_csv (r'data\disability.csv', index = None, header=True) #Don't forget to add '.csv' at the end of the path


# In[28]:


disability_pivot_df1 = disability_Yes_df[['ClientID','Determination','DisabilityType']].drop_duplicates()

disability_pivot_df1


# In[29]:


disability_pivot_df = pd.pivot(disability_pivot_df1, index = ['ClientID','DisabilityType'], columns = 'DisabilityType', values = 'Determination').drop_duplicates()

#disability_pivot_df


# In[30]:


disability_pivot_csv = disability_pivot_df.to_csv (r'data\disability_pivot.csv', index = None, header=True) #Don't forget to add '.csv' at the end of the path


# In[31]:



# Read in the SES data
ses_df = pd.read_csv(
    "https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project2_2019/EE_UDES_191102.tsv",     # relative python path to subdirectory
    sep='\t'           # Tab-separated value file.
    #quotechar="'",        # single quote allowed as quote character
    #dtype={"salary": int},             # Parse the salary column as an integer 
    ,usecols=['Client ID', 'Client Location(4378)', 'Zip Code (of Last Permanent Address, if known)(1932)']   # Only load the three columns specified.
    #parse_dates=['birth_date'],     # Intepret the birth_date column as a date
    #skiprows=10,         # Skip the first 10 rows of the file
 ,na_values=['**','NaN']       # Take any '.' or '??' values as NA
    ,header=0
)

ses_df.head(10)
#ee_total_rows = ee_df.count
#print (ee_total_rows)


####
#  ,na_values=['**','NaN'] --Not working


# In[32]:


ses_df.columns=['ClientID', 'Location', 'ZipCode']

ses_df.head(10)


# In[33]:


ses_csv = ses_df.to_csv (r'data\ses.csv', index = None, header=True) #Don't forget to add '.csv' at the end of the path


# In[34]:


# Read in the health insurance data
insurance_df = pd.read_csv(
    "https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project2_2019/HEALTH_INS_ENTRY_191102.tsv",     # relative python path to subdirectory
    sep='\t'           # Tab-separated value file.
    #quotechar="'",        # single quote allowed as quote character
    #dtype={"salary": int},             # Parse the salary column as an integer 
    ,usecols=['Client ID', 'Covered (Entry)', 'Health Insurance Type (Entry)', 'Health Insurance Start Date (Entry)']   # Only load the three columns specified.
    #parse_dates=['birth_date'],     # Intepret the birth_date column as a date
    #skiprows=10,         # Skip the first 10 rows of the file
 ,na_values=['**']       # Take any '.' or '??' values as NA
    ,header=0
)

insurance_df.head(10)
#EE_total_rows = EE_df.count
#print (EE_total_rows)


# In[35]:


insurance_df.columns=['ClientID', 'Covered', 'InsuranceType','StartDate']

insurance_df.head(10)


# In[36]:


insurance_csv = insurance_df.to_csv (r'data\insurance.csv', index = None, header=True) #Don't forget to add '.csv' at the end of the path


# In[37]:


#Get master file

master_df = client_df.join(ses_df, lsuffix='_demo',rsuffix='_ses').join(insurance_df, rsuffix='_ins').join(disability_pivot_df, rsuffix='_dis')
#how to reduce to columns of interest???
#usecols=['Client ID', 'Covered (Entry)', 'Health Insurance Type (Entry)', 'Health Insurance Start Date (Entry)']    


#pd.merge(client_df, ses_df, insurance_df, how='left', on='ClientID')
master_df.head(10)


##Contains duplicates


# In[38]:


# Declare a list that is to be converted into a column 
#master_df.count_ = ['1'] 
  
# Using 'Address' as the column name 
# and equating it to the list 
#master_df.[count_] = ['1'] 


# In[39]:


master_csv = master_df.to_csv (r'data\master.csv', index = None, header=True) #Don't forget to add '.csv' at the end of the path


# In[ ]:




