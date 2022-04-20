function [meanmad] = MeanMAD(prediction, testTarget)
prediction(4:6,:) = rad2deg(prediction(4:6,:));
testTarget(4:6,:) = rad2deg(testTarget(4:6,:));
meanmad = mean(mean(abs(testTarget-prediction),2));
end

