function [Kshotnoise,KCT1,KCT2,KCT3,KnoNoise1] = localContrastCrosstalk(imagepixelsizechoice,noisemeanmax)
%ALLSPECKLECONTRAST Summary of this function goes here
%   Detailed explanation goes here
noisemeans = 0:0.1:noisemeanmax;
noiseiterations = 100;

KnoNoise1=zeros(1,length(noisemeans));
Kshotnoise=zeros(noiseiterations,length(noisemeans));
KCT1=zeros(noiseiterations,length(noisemeans));
KCT2=zeros(noiseiterations,length(noisemeans));
KCT3=zeros(noiseiterations,length(noisemeans));

for i = 1:length(noisemeans)
noiseI = shotnoise(noisemeans(i),noiseiterations);
KnoNoise1(i) = meanlocalcontrast2(imagepixelsizechoice(:,:,1));
    for n = 1:noiseiterations
            
            Kshotnoise(n,i) = meanlocalcontrast2(imagepixelsizechoice+noiseI(:,:,n));
            KCT1(n,i) = meanlocalcontrast2(imgaussfilt(imagepixelsizechoice, 0.5 , 'FilterSize', 7)+noiseI(:,:,n));
            KCT2(n,i) = meanlocalcontrast2(imgaussfilt(imagepixelsizechoice, 0.4 , 'FilterSize', 7)+noiseI(:,:,n));
            KCT3(n,i) = meanlocalcontrast2(imgaussfilt(imagepixelsizechoice, 0.3 , 'FilterSize', 7)+noiseI(:,:,n));
           
        
    end
end

end

