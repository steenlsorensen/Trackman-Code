function [meanLocalK] = meanlocalcontrast2(Image)
%MEANLOCALCONTRAST Summary of this function goes here
%   Detailed explanation goes here
%pixel contrast kernel
kernelSize = 7;
Imean = imboxfilt3(Image,[kernelSize, kernelSize, 1],'padding', 'symmetric'); %calculate mean of kernel for each pixel
Istd = stdfilt(Image, ones(kernelSize, kernelSize, 1)); %calculate std of kernel for each pixel
pixelContrast = Istd./Imean; %contrast for each pixel
meanLocalK = mean(pixelContrast,'all');


end

