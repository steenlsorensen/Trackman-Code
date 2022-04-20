function [svmtrain,svmresult] = SVMCalc(trainData,trainTarget,testData)
% Regularize data
traindatareg = (trainData');
[traindataregZ,muZ, stdZ]= zscore(traindatareg);
testdatareg = (testData');
testdataregZ = (testdatareg-muZ)./stdZ;
traintargetreg = trainTarget';

svmt = zeros(size(trainTarget'));
svm1 = zeros(size(testData,2),6);

% Define parameters
boxconstraints3 = [ 0.15697,37.521 ,1.7498 ,0.018439 ,0.63123 ,30.995 ];
kernelscales3 = [ 0.23331,2.5322 ,0.30954 ,1.315 ,0.79303 ,23.14 ];
epsilons3 = [ 0.016822,0.11109 ,0.055629 ,7.5125e-05 ,0.0022362 ,0.00044043 ];

%fit SVM model on each dimension and predict
for i =1:6
svmmdl = fitrsvm(traindataregZ,traintargetreg(:,i),'KernelFunction','linear','BoxConstraint',boxconstraints3(i),'KernelScale',kernelscales3(i),'Epsilon',epsilons3(i));% mdl1 = fitrlinear(traindataregZ,traintargetreg(:,i));
svmt(:,i) = predict(svmmdl,traindataregZ);
svm1(:,i) = predict(svmmdl,testdataregZ);
end

svmtrain = svmt';
svmresult=svm1';
end

