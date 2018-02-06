# simple-backward-selection
Simple backward selection using linear models in R.

It reads the data and builds an initial model with all the attributes. Later, it fetches the p-values from the linear models' summary (Intercept excluded, only for coefficients). 
In each iteration, it drops one attribute which has the maximum p-value, and continues until all the p-values are less than 0.05.
