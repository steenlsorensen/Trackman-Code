Snippet of code from my masters Thesis

customnetEqdata.m - code that imports data recorded during an MRI, fits and calculates results from 3 different regression models:
Linear least squares regression, Support Vector Regression, and a neural network

functions:

Baseshiftcalc - performs a baseshift and calculates linear regression as well.

baseshiftapply - applies the linear regression and inverts the baseshift.

SVMcalc - fits and calculates result from an optimized support vector regression model.

NNDiffCalc - trains and predicts an optimized version of the NeuralNetwork.

spm_matrix and spm_imatrix - an often used way to perform baseshift when working with Brain images.
