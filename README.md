# Getting and Cleaning Data Course Project Submission

This project contains the run_analysis.R file. This file will download the data, run the analysis, and output data/mean_features.txt".

The analysis uses dplyr and tidyr to wrangle the data from a messy format into a tidy format. Each action is commented in the .R file so the code can be read easily.

## Code Book for mean_features.txt

Columns: subject, dataset, activity, estimate, axis, source, device, domain, is_jerk, is_magnitude, mean

- subject: the identification number of the user
- dataset: wheather the subject came from the testing or training condition
- activity: the action taken by the subject
- estimate: the processing used when taking the measurement
- axis: the direction of the measurement
- source: the source of the measurement (body or gravity)
- device: the type of device used for taking the measurement
- domain: whether time or frequency was used for the measurement
- is_jerk: if the measurement was a jerk
- is_magnitude: if the measurement was a magnitude
- mean: the average of the measurements for this grouping