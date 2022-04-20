function [pNNresults,NNDIFF ] = NNDiffCalc(ensembleiterations,trainData,trainTarget,testData,rLinTrain,rLinTest) %,pNNmin
%% prepare data
trainTarget = trainTarget-rLinTrain;

[trDnorm , setTD] = mapminmax(trainData);
[trTnorm , setTT] = mapminmax(trainTarget);
teDnorm = mapminmax.apply(testData,setTD);


%% Define network layers
layers = [
    sequenceInputLayer(24,"Name","featureinput")
%     dropoutLayer(0.1)
%     fullyConnectedLayer(15,"Name","fc_1")
    fullyConnectedLayer(70,"Name","fc_1")
%     batchNormalizationLayer
    tanhLayer("Name","tanh_1")
%     reluLayer("Name","relu_1")
%     customdropoutLayer2(0.2,'drop1')
    dropoutLayer(0.2)
    
%     fullyConnectedLayer(8,"Name","fc_2")
%     fullyConnectedLayer(50,"Name","fc_2")
%    batchNormalizationLayer
%     tanhLayer("Name","tanh_2")
%     reluLayer("Name","relu_2")
%     customdropoutLayer2(0.2,'drop2')
%     dropoutLayer(0.2)
%     fullyConnectedLayer(50,"Name","fc_4")
%    batchNormalizationLayer
%     tanhLayer("Name","tanh_4")
%     reluLayer("Name","relu_1")
%     dropoutLayer(0.3)
    
    fullyConnectedLayer(6,"Name","fc_3")
    regressionLayer("Name","regressionoutput")];
%     maeRegressionlayer('mae')];



%% Train network

NNDIFF = cell(1,ensembleiterations);
for i = 1:ensembleiterations

    idx2 = randperm(size(trainData,2),round(size(trainData,2)*0.15));
    validationData = trDnorm(:,idx2);
    trDnorm2 = trDnorm;
    trDnorm2(:,idx2) = [];
    validationTarget = trTnorm(:,idx2);
    trTnorm2 = trTnorm;
    trTnorm2(:,idx2) = [];

    options = trainingOptions('adam', ...
        'MiniBatchSize',ceil(size(trDnorm2,2)/5), ...
        'InitialLearnRate',0.01,...
        'Shuffle','every-epoch',...
        'MaxEpochs',1000, ...
        'ValidationPatience',5,...
        'ValidationData',{validationData,validationTarget}, ...'ValidationData',[], ...%
        'ValidationFrequency',25, ...
        'Verbose',false);
    
    
    net = trainNetwork(trDnorm2,trTnorm2,layers,options);

    NNDIFF{i} = net;
    pNNmat(:,:,i) = predict(net,teDnorm); 
end


%% calculate positions

pNN = mean(pNNmat,3);

pNNresults = mapminmax.reverse(pNN,setTT)+rLinTest;
end

