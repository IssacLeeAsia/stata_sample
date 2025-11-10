# README

## Overview

This repository contains a sample of STATA code authored by Bangyan (Martin) Chen, demonstrating his work at the Department of Radiology at New York University Langone Health. The code aims to replicate the data cleaning and analysis detailed in the methods and results sections of the paper titled *"Utilization of Hip and Knee MRI in Patients 50 and Above with Atraumatic Pain: An Analysis of the National Ambulatory Medical Care Survey."* All scripts are written in STATA 18.

## Repository Structure

The repository is organized into three main folders:

1. **data**
2. **do_files**
3. **manuscripts**

### Data

The **data** folder contains datasets from the National Ambulatory Medical Care Survey (NAMCS) for the years 2007 to 2019. Please note that the 2017 dataset is missing as it has not yet been released by the Centers for Disease Control and Prevention (CDC).

### Do Files

The **do_files** folder includes STATA `.do` files used for data cleaning, merging, and analysis. To replicate the results:

- Set your data directory at the beginning of each file.
- Optionally, save the output dataset to the original data directory or a new output folder.
- Ensure you are using STATA 18 or later versions, as the "dtable" function is required.

### Manuscripts

The **manuscripts** folder contains sections of the paper, including the introduction and methods, shared with permission from my supervisor.

## Usage

1. **Data Directory Setup**: Ensure that you set the correct data directory at the beginning of each `.do` file.
2. **STATA Version**: Use STATA 18 or later to ensure compatibility with the provided code, especially for the `dtable` function.
3. **Output Options**: Choose whether to save the processed datasets in the original data directory or a new output folder at your convenience.

## Contact

For any questions or further information, please contact Bangyan (Martin) Chen at bc3517@nyu.edu
