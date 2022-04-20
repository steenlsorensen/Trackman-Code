function [Contrast] = globalContrast(image)
%GLOBALCONTRAST Summary of this function goes here
%   Detailed explanation goes here
Contrast = std(image,0,[1, 2])./mean(image,[1,2]);
end

