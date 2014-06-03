Analysis of data - a checklist
===

You have done your experiment or received data from other people. We hope you have followed our recommendations about how to plan an experiment, which means that you should know what youre questions is and how to analyze your data, but we don't assume that this is the case. 

Follow this checklist

## Start a new project

In RStudio or whatever editor you are using, created file structure that makes sense, move raw data there. An example of a file structure could be 

+ data
+ scripts
+ output

It is highly advised and professional standard to put your complete project under a version control such as svn or git, but if this is the first time that you hear about this option and you are under time pressure, you may skip this for the moment.

## Make sure you know your question

To make sure you really know that you want to find out, write it down as a comment at the beginning of your R script! This helps you, and us if we need to help you. Make sure you formulate a QUANTITATIVE hypothesis or question.

Good examples

* I want to find out whether observations from the treatment group have a higher value of X than observations from the control group. 

Bad examples

* I want to know what oak trees like 
* Is there a difference between sites of type A and sites of type B 
 
## Check again whether your question is answerable with your data

Again, ideally your question comes before your data, but just in case you haven't quite settled down on your question, please consider again that you might have a good question, but do you also have the data for this question? Can you hope that you have more or less controlled your confounding variables? 

## Decide on statistical method

Ideally, as we recommend in our checklist for [Planning an Experiment](/checklists/planningAnExperiment.md), you can skip this step because you have already decided on an analysis method during your experimental planning, and have desiged your experiment or data collection for this method.

Yet, as experience has taught us you might have not, you might want to look at the decision tree [here](/checklists/whichAnalysis.md), noting that is not a complete replacement for getting an overview of the methods of statistics.

## Import and clean your data

* Import your data into R. See R help if you have problems
* Perform consistency checks, relabel, rename, reshape if neccesary
* Check whether and where you have NA values. Usually important for later analysis
* **NEVER change anything in your raw data file**, all changes are made in the R script!

## Visualize your data / Explorative data analysis (optional)

It's good style to plot your data. This helps to spot problems in the data and to get a feeling for what the results might be. Also, if you have no clear hypothesis, you may just do an explorative analysis and stop here. 

However, *it is usually not permissible to change your hypothesis after viewing the data*. In particular, it is highly wrong, forbidded, cheating to look at your data, and then to decide on your hypothesis (e.g. which groups you want to check for differences, or which effects to include in the model) after viewing your data. By that, you are doing hidden multiple comparisons, which typically will make your p-values larger than what they would be if you would explicitly test all the things that you looked at visually. 

That being said, as long as you don't adjust your hypothesis, look at the data in whatever way you want. If you spot something new that looks interesting, you either have to make clear what you looked at, or just treat this as a exploratory analysis. 

## Perform statistical analysis

Dome






