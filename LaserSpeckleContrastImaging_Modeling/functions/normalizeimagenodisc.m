function [normalizedImage] = normalizeimagenodisc(sumImages,targetMean,targetK,stdparenchyma)
%SUMANDNORMALIZE Summary of this function goes here
%   Detailed explanation goes here

targetSTD = targetMean*targetK;
normalizedI = zeros(size(sumImages,1),size(sumImages,2),3);
for i =1:3
normalizedI(:,:,i) =  targetMean + (((sumImages(:,:,i) - mean(sumImages(:,:,i),'all'))./stdparenchyma(i))*targetSTD);
%make this std of parenchyma for all
% 

end
% normalizedI(normalizedI>255) = 255;
normalizedImage = normalizedI;
% normalizedImage = Isummed;
end

