function [] = noisePlot(Ksp1,Ksp2,Ksp4,KnoNoise1,KnoNoise2,KnoNoise3,noisemeanmax)
%NOISEPLOT Summary of this function goes here
%   Detailed explanation goes here
color1 = [0 0.4470 0.7410]; %blue
color2 = [0.8500 0.3250 0.0980]; %red
color3 = [0.9290 0.6940 0.1250]; %orange
color4 = [0.4660 0.6740 0.1880]; %green

noisemean = 0:0.1:noisemeanmax;
Knonoisemean1=mean(KnoNoise1);
Knonoisemean2=mean(KnoNoise2);
Knonoisemean3=mean(KnoNoise3);

p1 = plot(noisemean,mean(Ksp1,1)./Knonoisemean1,'Color',color1);
hold on
% errorbar(noisemeans,mean(Ksp1,1),mean(Ksp1,1)-min(Ksp1,[],1) ,max(Ksp1,[],1)-mean(Ksp1,1),'.')
errorbar(noisemean(:,1:2:end),mean(Ksp1(:,1:2:end),1)./Knonoisemean1,std(Ksp1(:,1:2:end),1,1)./Knonoisemean1,'.','MarkerSize',1,'Color',color1);
p2 = plot(noisemean,mean(Ksp2,1)./Knonoisemean2,'Color',color4);
errorbar(noisemean(:,1:2:end),mean(Ksp2(:,1:2:end),1)./Knonoisemean2,std(Ksp2(:,1:2:end),1,1)./Knonoisemean2,'.','MarkerSize',1,'Color',color4);
p3 = plot(noisemean,mean(Ksp4,1)./Knonoisemean3,'Color',color3);
errorbar(noisemean(:,1:2:end),mean(Ksp4(:,1:2:end),1)./Knonoisemean3,std(Ksp4(:,1:2:end),1,1)./Knonoisemean3,'.','MarkerSize',1,'Color',color3);
p4 = plot(noisemean,KnoNoise1./Knonoisemean1,'Color',color2);
%p5=plot(noisemean,KnoNoise2./Knonoisemean2,'Color',color1);
%p6=plot(noisemean,KnoNoise3./Knonoisemean3,'Color',color4);
xlabel('Shotnoise mean')
% ylabel('Normalized mean local contrast')
ylabel('Normalized global contrast')
legend([p1 p2 p3 p4],'SPR 1','SPR 2','SPR 4', 'no noise');%,'no noise 2','no noise 3')
xlim([0 noisemeanmax])
%title('Ordered tauc 20')


end

