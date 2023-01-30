
import numpy as np
import pandas as pd
import math

def preprocess_dataset(dataFrame):
  """
  @desc    :  preprocess data set
  @params  :  dataFrame: pandas dataframe
  @returns :  preprocess dataset including GI values: pandas.DataFrame,\
    standardized training dataset:pandas.DataFrame,\
      GI values:pandas.Series,\
        training columns:List,\
          dataset mean & std: Dict
  """
  # Columns in training set
  TrainingColumns = ["Calories (kcal)", 'Protein (g)','Fats (g)', 'Carbs (g)', 'Fiber (g)', 'Sugar (g)','Phosphorus (mg)', 'Potassium (mg)', 'Sodium (mg)', 'Saturated Fat (g)', 'Trans Fat (g)']
  # Drop unwanted columns
  dataset = dataFrame.drop(labels=['Insulin index', 'Serving Size', 'Acidity (Based on PRAL)', 'Net Carbs ( grams)'], axis = 1)
  # Drop GI values
  dataset.dropna(subset = ['Glycemic index'], inplace=True)
  # Fill null with 0
  dataset = dataset.fillna(0)
  # Map GI Category to numeric value
  dataset['GI Category'] = dataset['GI Category'].map({'low':0, 'medium':1, 'high':2})
  # Pick only training columns from set
  data = dataset[TrainingColumns]
  # Standardize data
  dataMean =  np.mean(data, axis=0)
  dataStd =  np.std(data, axis=0)
  data = (data - dataMean) / dataStd

  return dataset, data,  dataset['GI Category'].values, TrainingColumns, {"mean":dataMean, "std":dataStd}


  # Return random food from given sub category with higher GI value
def get_random_gi_high_food(dataFrame, category):
  GI_high_food = dataFrame[dataFrame["GI"]==2]
  sample = GI_high_food[GI_high_food["Group"]==category]
  if(len(sample)!=0):
    return sample.sample().iloc[[0]]
  else:
    print(f"{category} has 0 GI high foods")
    GI_medium_food = dataFrame[dataFrame["GI"]==1]
    sample = GI_medium_food[GI_medium_food["Group"]==category]
    if len(sample)!=0:
      return sample.sample().iloc[[0]]
    else:
      print(f"{category} has 0 GI medium foods")

def select_cutoff(value, low_bound, high_bound):
  if 0 <=value <  low_bound:
    return "low"
  elif low_bound <= value <= high_bound:
    return "medium"
  else:
    return "high"

def apply_cutoff_labels(data):
  """
  @params: data : (numpy array) ["Calories (kcal)", 'Protein (g)','Fats (g)', 'Carbs (g)', 'Fiber (g)', 'Sugar (g)','Phosphorus (mg)', 'Potassium (mg)', 'Sodium (mg)', 'Saturated Fat (g)', 'Trans Fat (g)']
  @returns : (numpy array) [low, medium, high]
  """
  # Cut of criteria
  cut_off_values = {
      "Calories (kcal)":(100,200),
      "Protein (g)": (10, 20),
      "Fats (g)": (5,15),
      "Carbs (g)": (10, 30),
      "Fiber (g)": (1, 5),
      "Sugar (g)": (2, 12),
      "Phosphorus (mg)": (100, 300),
      "Potassium (mg)": (100, 300),
      "Sodium (mg)": (500, 1000),
      "Saturated Fat (g)": (20, 50),
      "Trans Fat (g)": (0.5, 2)
  }
  array = []
  for i,col in enumerate(cut_off_values.items()):
    array.append(select_cutoff(data[i], *col[1]))

  return np.array(array)

