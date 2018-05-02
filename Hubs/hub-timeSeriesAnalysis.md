---
layout: page
title: Time series methods
category: hubs
---

Time-series analysis is more tricky than one would assume at first glance. The reason is that often time series are analysed wrongly and people got used to that. In a time series, consecutive data points are typically **not** independent. If the weather is fine today, it is also likely to be fine tomorrow; or at least tomorrow's weather is not a random draw from weather conditions. This non-independence is the key complication in time-series analyses.

Most introductory statistics text books for non-statisticians avoid the analysis of time series because it requires a concept that is not in the basic stats curriculum: the variance-covariance matrix and Generalised Least Square regression (GLS). If they cover time series at all, the focus on detrending (removing long-term trends from the data), decomposition (identifying long-term fluctuations from short-term variation), spectral analysis (only for very long time series) and visualisation of the non-independence of data (autocorrelation functions). Actually analysing even simple trends in, say, water levels of a river requires more than that: it requires a specification of **how** the dependence varies with time. This is parameterised in the variance-covariance matrix, and fitted, e.g., by GLS.

A good starting point is Hyndman & Athanasopoulos' new book.

Please also check the introductory lecture in our StatsCafe (April 2018) as [PDF](https://biometry.github.io/APES/LectureNotes/2018-TimeSeries/intro-timeseries.pdf) or original [.Rnw](https://biometry.github.io/APES/LectureNotes/2018-TimeSeries/intro-timeseries.Rnw).


Literature
==
Hyndman & Athanasopoulos (2014) Forecasting: Principles and Practice; [open book](https://www.otexts.org/fpp)
