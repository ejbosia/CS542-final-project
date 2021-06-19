import pandas as pd
import numpy as np
import lightgbm as lgb

from sklearn.model_selection import train_test_split
from matplotlib import pyplot

'''
Clean and process the data
'''
def process_data():
    pass

'''
Train the model
'''
def train(X,Y):


    # parameters for LightGBMClassifier
    params = {
        'objective' :'binary',
        'learning_rate' : 0.02,
        'num_leaves' : 76,
        'feature_fraction': 0.64, 
        'bagging_fraction': 0.8, 
        'bagging_freq':1,
        'boosting_type' : 'gbdt',
        'metric': 'binary_logloss'
    }


    model = lgbm.LGBMClassifier()

    model.fit(X, Y)


def main():
    pass

if __name__ == "__main__":
    main()