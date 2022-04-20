clear all
addpath('functions')
addpath('Data')

load('sumImages.mat')


%% calculate Local or Global Contrast

stdParenchyma = squeeze(std(B500,0, [1 2]));
parenchymaK = 0.2;

%Local Contrast
[K20,K202,KnoNoise20,KnoNoisenodisc20] = intensityLocalContrast(O20,stdParenchyma, parenchymaK);
[K80,K802,KnoNoise80,KnoNoisenodisc80] = intensityLocalContrast(O80,stdParenchyma, parenchymaK);
[K500,K5002,KnoNoise500,KnoNoisenodisc500] = intensityLocalContrast(B500,stdParenchyma, parenchymaK);

% %global contrast
% [K20,K202,KnoNoise20,KnoNoisenodisc20] = intensityGlobalContrast(O20,stdParenchyma, parenchymaK);
% [K80,K802,KnoNoise80,KnoNoisenodisc80] = intensityGlobalContrast(O80,stdParenchyma, parenchymaK);
% [K500,K5002,KnoNoise500,KnoNoisenodisc500] = intensityGlobalContrast(B500,stdParenchyma, parenchymaK);


%% Visualize
titles = {'Large vessel, \tau_{c} = 20'; 'Medium vessel, \tau_{c} = 80'; 'Parenchyma, \tau_{c} = 500'};
figure
t=tiledlayout(1,3,'TileSpacing','compact','Padding','compact');
 title(t,'With Pixel crosstalk, Parenchyma contrast = 0.2')
%title(t,'With pixel crosstalk, Fixed pattern noise, Parenchyma contrast = 0.1')
    intensityPlot(K20,K202,KnoNoise20,KnoNoisenodisc20)
    title(titles{1})
%     ylim([0.6 2.2])
    ylim([0.7 1.5])
%     ylim([0.6 1.7])
    
    intensityPlot(K80,K802,KnoNoise80,KnoNoisenodisc80)
    title(titles{2})
%     ylim([0.6 2.2])
    ylim([0.7 1.5])
%     ylim([0.6 1.7])
    
    intensityPlot(K500,K5002,KnoNoise500,KnoNoisenodisc500)
    title(titles{3})
%     ylim([0.7 1.5])
    ylim([0.4 1.3])

