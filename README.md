# Children's Access to Mental Healthcare in Rural Wisconsin

In 2022, 28.1% of Wisconsin children aged 3-17 had a parent-reported Mental, Emotional, Developmental, or Behavioral (MEDB) issue. Despite this, only 9.6% of children received some form of mental healthcare.  

Of those who did, 82.1% of them lived in urban areas, while only 17.9% were from rural areas. This urban-rural divide can be attributed to three main barriers: Availability, Accessibility, and Affordability (Rural Health Information Hub, 2024).

•	Availability: There is an acute shortage of mental healthcare providers working in rural communities across the United States, and it is estimated that nearly 70% of rural counties do not have a practicing psychiatrist.  
  
•	Accessibility: Rural residents often must travel farther to access care due to the lack of providers in their own community.  

•	Affordability: Many insurance plans do not cover mental health services, and rural residents are more likely than urban residents to be uninsured.  

This project aims to identify rural Wisconsin counties most in need of additional support by analyzing county-level data related to these three main barriers impacting rural children’s access to mental healthcare. By pinpointing counties with a higher prevalence of these obstacles and examining the relationships between them, we can uncover new insights that will inform evidence-based interventions and recommendations. In addition to county-level data from Wisconsin, national survey data was utilized to identify specific predictors related to the receipt of needed mental healthcare. 

Source: [https://www.ruralhealthinfo.org/toolkits/mental-health/1/barriers]

This project was originally developed in R and has been translated to Python. The original R scripts are retained in `R_files/` for reference.  

## Project Overview

### Data Files

Primary and derived data in this repository include:

- `NSCH.csv` - 2022 National Survey of Children's Health (primary dataset). `NSCH.csv` was too big of a file to upload to this repository. You can request the 2022 file here: [(https://www.childhealthdata.org)]
- `CountyHealthNew.xlsx` 2024 County Health Rankings & Roadmaps (CHR), used for county level rankings in `StatisticalInference.ipynb` and hypothesis testing in `HypothesisTesting.ipynb` [https://www.countyhealthrankings.org/health-data/wisconsin/data-and-resources]
- `RUCC.xlsx` 2024 Rural-Urban Continuum Codes (RUCC), used to target "rural" counties (RUCC codes 4-9) [https://www.ers.usda.gov/data-products/rural-urban-continuum-codes]
- `FinalAll.csv`, `FinalRural.csv` (derived analysis datasets from `NSCH.csv`, used in `NSCHAnalysis.ipynb`, `LogisticRegression.ipynb`, and `Probability.ipynb`)

### Python Notebooks

- `Datasets.ipynb`
  - Data cleaning for the dataset `NSCH.csv`
  - `NSCH.csv` was too big of a file to upload to this repository. You can request the 2022 file here: [https://www.childhealthdata.org]
  - Exports the cleaned dataset `FinalRural.csv`, which is the dataset utilized in most of the following notebooks
- `NSCHAnalysis.ipynb`
  - Descriptive analysis of `NSCH.csv`, comparing U.S. and Wisconsin urban/rural rates of mental healthcare receipt (`RecMHC`) among children with MEDB issues (`MEDB`)
  - Produces summary tables and an accompanying visualization
- `LogisticRegression.ipynb`
  - Logistic regression models for predicting receipt of mental health care (`RecMHC`) using `FinalRural.csv`
  - Includes model comparisons and evaluation metrics
- `Probability.ipynb`
  - Probability and conditional probability calculations using `FinalRural.csv`
- `StatisticalInference.ipynb`
  - Rural Wisconsin county rankings (rural meaning RUCC codes 4-9) based on the statistically significant predictors identified in `LogisticRegression.ipynb`
  - County-level metrics from `CountyHealthNew.xlsx`
  - MHPRank (# of mental healthcare providers), ChildPovRank (% children in poverty), and SPRank (% children in single-parent households) are calcucated separately, then summed to create a final combined rank
- `HypothesisTesting.ipynb`
  - Hypothesis testing and Pearson correlation analysis based on Wisconsin counties (RUCC 4-9)

### R scripts

R originals are stored in `R_files/` and mirror the Jupyter notebooks:

- `R_files/DataImport.R` (no equivalent notebook)
- `R_files/NSCHVars.R` (equivalent notebook is `Datasets.ipynb`)
- `R_files/NSCHAnalysis.R`
- `R_files/LogisticRegression.R`
- `R_files/Probability.R`
- `R_files/StatisticalInference.R`
- `R_files/HypothesisTesting.R`
- `R_files/Viz.R` (no equivalent notebook)


## Environment Setup

Python 3.10+ is recommended.

Install dependencies:

```bash
pip install -r requirements.txt
```

## Running the Analysis

Run notebooks from the repository root so relative file paths resolve correctly:

1. Open Jupyter:

```bash
jupyter notebook
```

2. Execute notebooks in this order for full reproducibility:
   1. `Datasets.ipynb`
   2. `NSCHAnalysis.ipynb`
   3. `HypothesisTesting.ipynb`
   4. `Probability.ipynb`
   5. `LogisticRegression.ipynb`
   6. `StatisticalInference.ipynb`


