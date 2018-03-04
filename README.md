# **Compositional Analysis & Statistics Suite (CASS)**

This package (under development) and Shiny app are a suite of statistical analyses and visualizations for user-input compositional data.  It was developed for evaluating chemical relationships between iron slag samples based on the methodologies outlined in Stetkiewicz (2016).

## Setup

You'll need to convert your spreadsheet into .CSV format before uploading it.
* Data will be imported as-is, so each column and row should have a logical title to make analysis and organization easier. 
* For optimal usage, make sure the oxide names of your dataframe are capitalized (i.e. 'FeO', 'SiO2', etc.) - some of the analyses have presets that use these titles. 
* If you intend to use the PCA or Correlation Matrix functions, you will need to remove any string vectors prior to those analyses. This can be done in the Modified Data tab.

## Acknowledgments

Like all open-source programs, this project builds off several existing codes and credit goes to each respective R package developer (ggplot2, Shiny, etc.). In particular, [SparseData's Clustering package](https://github.com/sparsedata/cluster-analysis) was immensely helpful in developing this interface, [Barret Schloerke](https://github.com/schloerke) helped with the correlation heatmap, and Nicholas Hamilton's [ggtern package](http://www.ggtern.com) is just plain amazing.  The methods used in this package are largely drawn from several archaeometallurgical publications, which are cited more thoroughly in Stetkiewicz (2016).

## Citation

If you've found this app useful, please cite it in your research as follows:

Stetkiewicz, Scott (2016). Compositional Analysis & Statistics Suite (CASS). https://github.com/ScottStetkiewicz/CASS
