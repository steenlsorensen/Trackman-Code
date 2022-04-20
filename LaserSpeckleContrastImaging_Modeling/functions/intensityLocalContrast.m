function [K1,K2,KnoNoise,KnoNoisenodisc] = intensityLocalContrast(images,stdParenchyma, parenchymaK)
%INTENSITYLOCALCONTRAST Summary of this function goes here
%   Detailed explanation goes here
intensityValues = 1:255;
noiseiterations = 100;
specklesizechoice = 2;

KnoNoise=zeros(1,length(intensityValues));
KnoNoisenodisc=zeros(1,length(intensityValues));
K1=zeros(noiseiterations,length(intensityValues));
K2=zeros(noiseiterations,length(intensityValues));


%Ks = zeros(length(intensityValues),3);
for i = 1:length(intensityValues)
    normO20 = normalizeimage(images,intensityValues(i),parenchymaK,stdParenchyma);
    normO20nodisc = normalizeimagenodisc(images,intensityValues(i),parenchymaK,stdParenchyma);
    
    noiseI = shotnoise(1,noiseiterations);
    noiseI2 = shotnoise(3,noiseiterations);
    
    KnoNoise(i) = meanlocalcontrast2(normO20(:,:,specklesizechoice));
    KnoNoisenodisc(i) = meanlocalcontrast2(normO20nodisc(:,:,specklesizechoice));
    for n = 1:noiseiterations
%             K1(n,i) = meanlocalcontrast2(normO20(:,:,specklesizechoice)+noiseI(:,:,n));
%             K2(n,i) = meanlocalcontrast2(normO20(:,:,specklesizechoice)+noiseI2(:,:,n));
            %with Crosstalk
            K1(n,i) = meanlocalcontrast2(imgaussfilt(normO20(:,:,specklesizechoice),0.5,'FilterSize',7)+noiseI(:,:,n));
            K2(n,i) = meanlocalcontrast2(imgaussfilt(normO20(:,:,specklesizechoice),0.5,'FilterSize',7)+noiseI2(:,:,n));
            
    end
%     
%     K = meanlocalcontrast(norm);
%     Ks(i,:)=K;
end
end

