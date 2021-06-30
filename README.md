# cs542_ml_project
Final project for CS542 (machine learning) at BU.

# Requirements
LightGBM requires the use of 64 bit python 3. Required libraries can be installed using:

```bash
pip install -r requirements.txt
```
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

# Feature Engineering
Feature engineering was done in SAS.

# Model Training
Model training is done by running the "model_training.ipynb" notebook.

# Results Analysis
Results analysis of the model can be run through the "results.ipynb" notebook.
