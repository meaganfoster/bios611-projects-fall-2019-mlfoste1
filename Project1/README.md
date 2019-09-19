Project1
==============================



Description
------------

Data exploration of the "UMD_Services_Provided_20190719.tsv" dataset provided by the Urban Ministry of Durham.  



------------



Metadata
------------

Date	Date service was provided**

Client File Number	Family identifier (individual or family)**

Client File Merge	Separate files were created for one family and merged later**

Bus Tickets (Number of)	 Service discontinued.

Notes of Service	

Food Provided for	Number of people in the family for which food was provided**

Food Pounds**	

Clothing Items**	

Diapers**

School Kits**

Hygiene Kits**

Referrals	Ignore this column


Financial Support	Money provided to clients. Service discontinued.


**Fields of interest

------------


Instructions
------------

Additional data sets were included in this analysis.  See links below.


------------


Additional Dataset Sources
------------

https://live-durhamnc.opendata.arcgis.com/datasets/homeless-population-point-in-time-count/data

https://live-durhamnc.opendata.arcgis.com/datasets/foreclosure-2006-to-2016


------------





Project Organization
------------

    ├── LICENSE
    ├── Makefile           <- Makefile with commands like `make data` or `make train`
    ├── README.md          <- The top-level README for developers using this project.
    ├── data
    │   ├── external       <- Data from third party sources.
    │   ├── interim        <- Intermediate data that has been transformed.
    │   ├── processed      <- The final, canonical data sets for modeling.
    │   └── raw            <- The original, immutable data dump.
    │
    ├── docs               <- A default Sphinx project; see sphinx-doc.org for details
    │
    ├── models             <- Trained and serialized models, model predictions, or model summaries
    │
    ├── notebooks          <- Jupyter notebooks. Naming convention is a number (for ordering),
    │                         the creator's initials, and a short `-` delimited description, e.g.
    │                         `1.0-jqp-initial-data-exploration`.
    │
    ├── references         <- Data dictionaries, manuals, and all other explanatory materials.
    │
    ├── reports            <- Generated analysis as HTML, PDF, LaTeX, etc.
    │   └── figures        <- Generated graphics and figures to be used in reporting
    │
    ├── requirements.txt   <- The requirements file for reproducing the analysis environment, e.g.
    │                         generated with `pip freeze > requirements.txt`
    │
    ├── setup.py           <- makes project pip installable (pip install -e .) so src can be imported
    ├── src                <- Source code for use in this project.
    │   ├── __init__.py    <- Makes src a Python module
    │   │
    │   ├── data           <- Scripts to download or generate data
    │   │   └── make_dataset.py
    │   │
    │   ├── features       <- Scripts to turn raw data into features for modeling
    │   │   └── build_features.py
    │   │
    │   ├── models         <- Scripts to train models and then use trained models to make
    │   │   │                 predictions
    │   │   ├── predict_model.py
    │   │   └── train_model.py
    │   │
    │   └── visualization  <- Scripts to create exploratory and results oriented visualizations
    │       └── visualize.py
    │
    └── tox.ini            <- tox file with settings for running tox; see tox.testrun.org


--------



Contact 
--------

Meagan Foster

Github: mlfoste1





References
------------

https://indyweek.com/news/archives/homeless-numbers-durham-reach-10-year-high/


--------
<p><small>Project based on the <a target="_blank" href="https://drivendata.github.io/cookiecutter-data-science/">cookiecutter data science project template</a>. #cookiecutterdatascience</small></p>
