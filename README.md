---
title: "NormalDistributionTests"
output: html_document
---

![](/home/scott/Pictures/pp.png)

## Usage

This Shiny app is designed to provide a quick, reactive means of uploading any dataset and exploring several popular methods of assessing distribution normality.

Simply upload your data, select the variable you wish to test, and app will provide:

* The *p*-value of the Shaprio-Wilk test
* The *p*-value of the Anderson-Darling test
* A visualization of the data distribution
* A quantile-quantile plot with a qqline

If there are known groups in your dataset that may be impacting the overall distribution of the tested variable, you can select the grouping variable option to view individual color-coded subset distributions.    

## Transformations

If your data does not appear to be normally distributed, you can see how applying square-root, cube-root and logarithmic transformations impacts the tests/visualizations. 

