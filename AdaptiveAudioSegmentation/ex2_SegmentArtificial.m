%% Part 2 : Adaptive Segmentation Algorithm on the artificial signal
addpath functions
% Load ADS parameters
load('ads.mat')

% Adaptive Segmentation of the Artificial Digital Signal
w1 = 1500;                  % window size of reference and moving windows
winPerc1 = 0.4;             % lag window is 10% of the window length
wA1 = 1.7;   %1.5                 % amplitude distance weight
wF1 = 5.1;     %5.1               % frequency distance weight
step1 = 10;                  % steps the moving window moves each iteration
[segStart1,distA1,distF1,distance1] = adaptSegment(ads,w1,wA1,wF1,winPerc1,step1); %Adaptive Segmentation

% Plot the ADS segmentation
plotIt(ads,fs,segStart1,distance1,distA1,distF1,wA1,wF1,step1,rL(2:end-1))