# cs542_ml_project
Final project for CS542 (machine learning) at BU.

# Evaluation Instructions (on SCC)
*I would recommend looking at this: the size of the data, models, and training time are significant*

All of the results and models are available on the SCC. To view, open a jupyter session with these parameters:

| Parameter          | Value                                                                        |
|--------------------|------------------------------------------------------------------------------|
| modules            | python3/3.8.10                                                               |
| prelaunch commands | source /projectnb/cs542sp/netflix_wrw2/CS542-final-project/venv/bin/activate |
| interface          | notebook                                                                     |
| working directory  | /projectnb/cs542sp/netflix_wrw2/CS542-final-project/                         |
| number cores*      | 8-16 *(for training)*                                                        |

This will open the notebook in the virtual environment that includes all of the dependencies for running training and analysis. The preprocessed data is also avaialble on the SCC.

There are two notebooks available for testing:
 - model_training.ipynb ~ code for training a LightGBM model
 - results.ipynb ~ code to analyze the LightGBM model vs the Netflix answer key

# Execution Instructions (code process)

## Requirements
Data upload and analytic set creation code was run in SAS 9.4

LightGBM requires the use of 64 bit python 3. Required libraries can be installed using:

```bash
pip install -r requirements.txt
```
## Downloading Data
Data is held on: https://www.kaggle.com/netflix-inc/netflix-prize-data

SAS Code to get data for model. To start first need to take all "combined_data" 1-4 in the Kaggle link and replace every ":" with ", ,           "
Also grab the movie titles data from the kaggle (more for interest, we didn't have time to search titles for underlying movie information that could have been useful)
This is since the dataset is set up weirdly with movies first then user, rating, date in an uneven order behind it. Since it is only 4 "control H" commands felt easier than doing more complicated and timeconsuming work for formatting input code. 

Then once all code is in the same folder everything else is set in the work environment to not clog up disk space. If you follow the order number of the start digit of the SAS files it will run but after a pretty long time.

## Feature Engineering
Feature engineering was done in SAS. Can be viewed in file: 2_Movie_User_Vars

## Model Training
Model training is done by running the "model_training.ipynb" notebook. You will need to change the path to the location data file in line 5 to read from the file output by the SAS workflow. 
 - set the number of threads to the number of CPUs available on the system (more is faster) ~ cell 6.
 - set the save location of the model ~ last cell

## Results Analysis
Results analysis of the model can be run through the "results.ipynb" notebook. You need to select the model to run in cell 5. No models are saved on the repository, so you will need to load the model created from the previous step. The metrics are output in the last few cells.
