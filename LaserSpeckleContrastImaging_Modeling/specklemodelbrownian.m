clear,close all
addpath functions
rng(0);
tic
%source
c = 300000000; %speed of light micrometer/micros
lambda = 0.785; %mum
k=2*pi/lambda; %wavenumber
%amplitude we use 1/distance

%volume
sizeX = 500; %mum
sizeY = 500; %mum
sizeZ = 500; %mum

particleN = 300;

%particles

particleX = rand(particleN,1)*sizeX; %(random position within volume)
particleY = rand(particleN,1)*sizeY;
particleZ = rand(particleN,1)*sizeZ;

%sensor
pixelsNx = 50;
pixelsNy = 50;
pixelSize = 12; %mum

sensorX = sizeX/2;
sensorY = sizeY/2;
sensorZ = sizeZ*10;

%calculated parameters
%pixelpositions
pixelPosX = sensorX + ones(pixelsNx,1)*((1:pixelsNx)-0.5*pixelsNx).*pixelSize;
pixelPosY = sensorY + ((1:pixelsNy)'-0.5*pixelsNy)*ones(1,pixelsNy).*pixelSize;


%initialize the field
timePeriod = 500;
I=zeros(pixelsNx,pixelsNy,timePeriod);

d = 0.0071; %displacement

%% calculate particle (field)
for t = 1:timePeriod %introduce time for motion modeling
    
    E=zeros(pixelsNx,pixelsNy);
    for i = 1:particleN
        r = sqrt((particleX(i) - pixelPosX).^2 + (particleY(i) - pixelPosY).^2 + (particleZ(i) - sensorZ).^2);

%         E = E+exp(1i*k*r)./r; %normally with omega*t
        E = E + exp(1i*k*r -1i*k*c*t)./r;
    end
    
    I(:,:,t) = E.*conj(E);

    %brownian random motion,
    particleX = particleX+d*randn(particleN,1);
    particleY = particleY+d*randn(particleN,1);
    particleZ = particleZ+d*randn(particleN,1);
    
    %force particles to stay in volume 
    particleX=mod(particleX,sizeX);
    particleY=mod(particleY,sizeY);
    particleZ=mod(particleZ,sizeZ);
   if mod(t,100)==0
       fprintf('\niteration number %d\n', t)
   end
   
end
 %intensity
I = I/mean(I(:));
toc

%%
%vizualisation
figure
for i = 1:timePeriod
    imagesc(I(:,:,i))
    axis image
    pause(0.01);
end

%% G2
g2=getG2(I,600);
g2=squeeze(mean(g2,[1,2]));
% g2=g2(1:find(g2<=1,1,'first'));
t=0:length(g2)-1;
figure
plot(t,g2)
xlabel('Time lag')
ylabel('g2')
set(gcf,'color','w');
title('Brownian motion')

%% specklesize

speckleSize = getSpeckleSize(I(:,:,1),5);

%% contrast
csumI = cumsum(I,3);
%full image
for i=1:10
    contrastI(i) = std(csumI(:,:,i),0,[1, 2])./mean(csumI(:,:,i),[1,2]);
end

%pixel contrast 5x5 kernel
kernelSize = 5;
ImChoice  = csumI(:,:,3);

Imean = imboxfilt3(ImChoice,[kernelSize, kernelSize, 1],'padding', 'symmetric'); %calculate mean of kernel for each pixel
Istd = stdfilt(ImChoice, ones(kernelSize, kernelSize, 1)); %calculate std of kernel for each pixel
pixelContrast = Istd./Imean; %contrast for each pixel

%% visualization
figure
imagesc(pixelContrast)
axis image
