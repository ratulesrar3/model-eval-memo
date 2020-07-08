# Model Evaluation Work Sample

## Background

In January 2019, the Los Angeles County Department of Mental Health (DMH) began efforts to develop predictive models for risk of homelessness among first -time clients of County mental health clinics, with a view to using the models as the basis of a targeted intervention. The exact form of the intervention is yet to be decided, but it will most likely involve providing clients with additional services, such as intensive case management and housing subsidies, that aim to reduce inflows into the emergency shelter system. To improve the predictive accuracy of the models, DMH has also signed an agreement with the LA County Sheriff to integrate arrest data.

## Data

There are two data sets: **DMH.csv** and **Sheriff.csv**. DMH.csv is the main dataset showing admission dates for all DMH clients who were treated in County mental health clinics in calendar year 2018, a binary variable **homeless** which indicates whether or not the client entered an emergency shelter in the 12 months following their date of first treatment, and demographic information about the client. Sheriff.csv contains arrest dates for any clients in DMH.csv who were arrested in calendar years 2015-19.

## Evaluation of Predictive Models

DMH has hired a consultancy to develop a machine learning model for predicting whether or not a DMH client would enter an emergency shelter in the 12 months following their first visit to a DMH clinic. As a proof-of -concept, the consultancy has generated two candidate models whose predicted probabilities, stored in the columns **m1_pred_prob** and **m2_pred_prob** in DMH.csv, are to be evaluated against known binary outcomes stored in the **homeless** column.

DMH estimates they are able to serve a maximum of 500 people in a given year through a targeted intervention strategy. The memo analyzes the ML models using evaluation frameworks for supervised learning, and recommends which model to deploy for a targeted homelessness intervention system. 		

## Included Files

1. `eda_model_eval_notebook.ipynb` (explores questions around the data and evaluates the provided model's calculated probabilities)
2. `eda_ddl.sql` (ddl for loading datasets to a postgres db)
3. `model_eval_memo.pdf` (memo includes model analysis and recommendations for DMH)
