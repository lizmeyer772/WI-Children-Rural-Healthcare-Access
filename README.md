# WI Children Rural Healthcare Access (R to Python Translation)

This repository analyzes mental health care access for children in rural Wisconsin counties, with a focus on children with mental, emotional, developmental, or behavioral (MEDB) conditions.

The project was originally developed in R and has been translated to Python notebooks. The original R scripts are retained in `R_files/` for reference and reproducibility checks.

## Repository Overview

### Python notebooks (translated workflow)

- `Datasets.ipynb`
  - Builds cleaned analysis datasets from `NSCH.csv`
  - Exports `FinalAll.csv` and `FinalRural.csv`
- `NSCHAnalysis.ipynb`
  - Descriptive analysis for Wisconsin and urban/rural comparisons
  - Produces summary tables and visualization output (e.g., `test.png`)
- `LogisticRegression.ipynb`
  - Logistic regression models for predicting receipt of mental health care (`RecMHC`)
  - Includes model comparison and ROC/AUC-oriented evaluation
- `Probability.ipynb`
  - Probability and conditional probability calculations using `FinalRural.csv`
- `StatisticalInference.ipynb`
  - Rural county ranking and inference-related summaries using county-level inputs
- `HypothesisTesting.ipynb`
  - Hypothesis testing and correlation analysis on rural county variables

### R reference scripts

R originals are stored in `R_files/` and mirror the notebook topics:

- `R_files/DataImport.R`
- `R_files/NSCHVars.R`
- `R_files/NSCHAnalysis.R`
- `R_files/LogisticRegression.R`
- `R_files/Probability.R`
- `R_files/StatisticalInference.R`
- `R_files/HypothesisTesting.R`
- `R_files/Viz.R`

## Data Files

Primary and derived data in this repository include:

- `NSCH.csv` (primary survey source)
- `CountyHealth.xlsx`, `CountyHealthNew.xlsx`
- `CHRAllWI.xlsx`, `RUCC.xlsx`
- `FinalAll.csv`, `FinalRural.csv` (derived analysis datasets)

Generated image assets include:

- `DataViz.png`
- `test.png`

## Environment Setup

Python 3.10+ is recommended.

Install required packages:

```bash
pip install pandas numpy scipy matplotlib scikit-learn statsmodels openpyxl jupyter
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
   3. `LogisticRegression.ipynb`
   4. `Probability.ipynb`
   5. `StatisticalInference.ipynb`
   6. `HypothesisTesting.ipynb`

## Key Variables Used in Modeling

Common variables used across notebooks:

- Predictors: `Ins`, `InsTypes`, `CGEmploy`, `Family`, `FPL`, `Sex`, `Race`, `Age`, `Aces`
- Additional context: `Metro`, `MEDB`
- Outcome: `RecMHC` (received mental health care in past 12 months)

## Notes on Translation

- Python notebooks preserve the structure and intent of the original R analyses.
- `R_files/` remains available for side-by-side validation and historical reference.
- Some notebook cells include exploratory or intermediate outputs; rerunning notebooks regenerates these results.
