function [Ksp1,Ksp2,Ksp4,KnoNoise1,KnoNoise2,KnoNoise3] = allSpeckleGlobalK(meanimageframes,noisemeanmax)
%ALLSPECKLECONTRAST Summary of this function goes here
%   Detailed explanation goes here
noisemeans = 0:0.1:noisemeanmax;
noiseiterations = 100;

KnoNoise1=zeros(1,length(noisemeans));
KnoNoise2=zeros(1,length(noisemeans));
KnoNoise3=zeros(1,length(noisemeans));
Ksp1=zeros(noiseiterations,length(noisemeans));
Ksp2=zeros(noiseiterations,length(noisemeans));
Ksp4=zeros(noiseiterations,length(noisemeans));

for i = 1:length(noisemeans)
noiseI = shotnoise(noisemeans(i),noiseiterations);
KnoNoise1(i) = globalContrast(meanimageframes(:,:,1));
KnoNoise2(i) = globalContrast(meanimageframes(:,:,2));
KnoNoise3(i) = globalContrast(meanimageframes(:,:,3));
    for n = 1:noiseiterations
            
            Ksp1(n,i) = globalContrast(meanimageframes(:,:,1)+noiseI(:,:,n));
            Ksp2(n,i) = globalContrast(meanimageframes(:,:,2)+noiseI(:,:,n));
            Ksp4(n,i) = globalContrast(meanimageframes(:,:,3)+noiseI(:,:,n));
%            %with pixel crosstalk
%             Ksp1(n,i) = globalContrast(imgaussfilt(meanimageframes(:,:,1),0.5,'FilterSize',7) +noiseI(:,:,n));
%             Ksp2(n,i) = globalContrast(imgaussfilt(meanimageframes(:,:,2),0.5,'FilterSize',7)+noiseI(:,:,n));
%             Ksp4(n,i) = globalContrast(imgaussfilt(meanimageframes(:,:,3),0.5,'FilterSize',7)+noiseI(:,:,n));
           
        
    end
end

end

