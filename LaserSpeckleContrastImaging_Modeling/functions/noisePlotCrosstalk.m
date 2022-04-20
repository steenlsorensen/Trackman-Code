function [] = noisePlotCrosstalk(Kshotnoise,KCT1,KCT2,KCT3,KnoNoise1,noisemeanmax)
%NOISEPLOT Summary of this function goes here
%   Detailed explanation goes here
color1 = [0 0.4470 0.7410]; %blue
color2 = [0.8500 0.3250 0.0980]; %red
color3 = [0.9290 0.6940 0.1250]; %orange
color4 = [0.4660 0.6740 0.1880]; %green
color5 = [0.6350 0.0780 0.1840]; %dark red

noisemean = 0:0.1:noisemeanmax;
Knonoisemean1=mean(KnoNoise1);


p1 = plot(noisemean,mean(Kshotnoise,1)./Knonoisemean1,'Color',color5);
hold on
errorbar(noisemean(:,1:2:end),mean(Kshotnoise(:,1:2:end),1)./Knonoisemean1,std(Kshotnoise(:,1:2:end),1,1)./Knonoisemean1,'.','MarkerSize',1,'Color',color5);
p2 = plot(noisemean,mean(KCT1,1)./Knonoisemean1,'Color',color1);
% errorbar(noisemeans,mean(Ksp1,1),mean(Ksp1,1)-min(Ksp1,[],1) ,max(Ksp1,[],1)-mean(Ksp1,1),'.')
errorbar(noisemean(:,1:2:end),mean(KCT1(:,1:2:end),1)./Knonoisemean1,std(KCT1(:,1:2:end),1,1)./Knonoisemean1,'.','MarkerSize',1,'Color',color1);
p3 = plot(noisemean,mean(KCT2,1)./Knonoisemean1,'Color',color4);
errorbar(noisemean(:,1:2:end),mean(KCT2(:,1:2:end),1)./Knonoisemean1,std(KCT2(:,1:2:end),1,1)./Knonoisemean1,'.','MarkerSize',1,'Color',color4);
p4 = plot(noisemean,mean(KCT3,1)./Knonoisemean1,'Color',color3);
errorbar(noisemean(:,1:2:end),mean(KCT3(:,1:2:end),1)./Knonoisemean1,std(KCT3(:,1:2:end),1,1)./Knonoisemean1,'.','MarkerSize',1,'Color',color3);
p5 = plot(noisemean,KnoNoise1./Knonoisemean1,'Color',color2);
%p5=plot(noisemean,KnoNoise2./Knonoisemean2,'Color',color1);
%p6=plot(noisemean,KnoNoise3./Knonoisemean3,'Color',color4);
xlabel('Shotnoise mean')
ylabel('mean local contrast')
legend([p1 p2 p3 p4 p5],'Shot noise','Crosstalk 0.5','Crosstalk 0.4','Crosstalk 0.3', 'no noise');%,'no noise 2','no noise 3')
xlim([0 noisemeanmax])
%title('Ordered tauc 20')


end

