function [shotnoiseimages] = shotnoise(expmean,numberofimages)
%SHOTNOISE Summary of this function goes here
%   Detailed explanation goes here

shotnoiseimages = round(exprnd(expmean,100,100,numberofimages));

% %%fixed pattern
% fixednoise = zeros(100,100);
% pixels = numel(fixednoise);
% meanfixed = 3.5;
% sigma = 1.35;
% idx = randperm(pixels);
% percentfixednoise = 0.1;
% fixednoisepixels = idx(1:floor(pixels*percentfixednoise));
% 
% %fixednoise = zeros(100,100);
% for i=1:100
%     fixednoise = zeros(100,100);
% fixednoise(fixednoisepixels) = fixednoise(fixednoisepixels)+ round(abs(normrnd(meanfixed,sigma,1,floor(pixels*percentfixednoise))));
% shotnoiseimages(:,:,i) = shotnoiseimages(:,:,i)+fixednoise;
% end
end


