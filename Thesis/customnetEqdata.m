clear all
addpath functions
addpath Data
%% select data, and prepare test and train data
Datasource = 0;

if Datasource ==1
    load J6381A_train5ch8co1noNorm.mat W_vNav r_spm r_vNav

    dw = squeeze(W_vNav(1:3,:,:,:));

    dw2 = reshape(dw,size(dw,1)*8,length(dw));

    dr = squeeze(r_spm);

    trainData = dw2(:,:);
    trainTarget = dr(:,:);


    load J6381r_move1tr2ch8co3.mat
    dw = squeeze(W_flash(1:3,:,:));

    dw2 = reshape(dw,size(dw,1)*8,length(dw));

    dr = squeeze(r_spmOld);

    testData = dw2;
    testTarget = dr;


else
    load 'r_spmTotal2.mat' r_spm
    load w_vNavtotal2.mat
    trainTarget = r_spm;
    trainData = W_vNavtotal;
    % data indexes
    %Dataorder: 1,2,3,4,5,move,still
    % data1: 1:399,
    % data2: 400:798
    % data3: 799:1197
    % data4: 1198:1596
    % data5: 1597:2795
    % move1: 2796:3035
    % still1: 3036:3275

    dataidx = {1:399;400:798;799:1197;1198:1596;1597:2795;2796:3035;3036:3275};

    tic

    trainDataidx = dataidx{1};
    testDataidx = dataidx{3};

    testData = trainData(:,testDataidx);
    trainData = trainData(:,trainDataidx);
    testTarget = trainTarget(:,testDataidx);
    trainTarget = trainTarget(:,trainDataidx);
    
end

%% Linear models calc

[A,M_vec,M_spm,U] = Baseshiftcalcorig(trainData,trainTarget);
[rLinTrain,MTrain] = Baseshiftapplyorig(trainData,A,U);
[rLinTest,MTest] = Baseshiftapplyorig(testData,A,U); 

[A2,M_vec2,M_spm2,U2] = Baseshiftcalcorig2(trainData,trainTarget);
[rLinTrain2,MTrain2] = Baseshiftapplyorig2(trainData,A2,U2);
[rLinTest2,MTest2] = Baseshiftapplyorig2(testData,A2,U2); 

%% SVM
[svmTrain,svm1] = SVMCalc(trainData,trainTarget,testData);

%% NN

pNN1lin2 = NNDiffCalc(1,trainData,trainTarget,testData,rLinTrain2,rLinTest2);
pNN1lin = NNDiffCalc(1,trainData,trainTarget,testData,rLinTrain,rLinTest);


%% subtract mean
testTarget = testTarget - mean(testTarget,2);
rLinTest2 = rLinTest2 - mean(rLinTest2,2);
rLinTest = rLinTest - mean(rLinTest,2);
svm1 = svm1 - mean(svm1,2);
pNN1lin2 = pNN1lin2 - mean(pNN1lin2,2);
pNN1lin = pNN1lin - mean(pNN1lin,2);


%% MAD Calculation

meanmadLin2mean = MeanMAD(rLinTest2,testTarget);
meanmadLinmean = MeanMAD(rLinTest,testTarget);
meanmadSVMmean = MeanMAD(svm1,testTarget);
meanmadNN2 = MeanMAD(pNN1lin2,testTarget);
meanmadNN = MeanMAD(pNN1lin,testTarget);

%% Output
disp(['meanmadLin2mean = ',num2str(meanmadLin2mean)])
disp(['meanmadLinmean = ',num2str(meanmadLinmean)])
disp(['meanmadSVMmean = ',num2str(meanmadSVMmean)])
disp(['meanmadNN2mean = ',num2str(meanmadNN2)])
disp(['meanmadNNmean = ',num2str(meanmadNN)])

%% Plot
plotMAD2(testTarget,rLinTest,pNN1lin2,svm1);









