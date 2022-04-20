function [] = intensityPlot(noise1,noise2,nonoise,nodisc)
%INTENSITYPLOT Summary of this function goes here
%   Detailed explanation goes here
intensityValues = 1:255;
color1 = [0 0.4470 0.7410]; %blue
color2 = [0.8500 0.3250 0.0980]; %red
color3 = [0.9290 0.6940 0.1250]; %orange
color4 = [0.4660 0.6740 0.1880]; %green

% noise1 = noise1/nodisc;
% noise2 = noise2/nodisc;
% nonoise = nonoise/nodisc;
% nodisc = nodisc/nodisc;
nodiscmean = mean(nodisc);

%tiledlayout(1,3,'TileSpacing','compact','Padding','compact')
nexttile
 p1 = plot(intensityValues,mean(noise1,1)./nodiscmean,'Color',color1);
hold on
errorbar(intensityValues(:,1:8:end),mean(noise1(:,1:8:end),1)./nodiscmean,std(noise1(:,1:8:end),1,1)./nodiscmean,'.','MarkerSize',1,'Color',color1);
% errorbar(intensityValues,mean(Ko20,1),mean(Ko20,1)-std(Ko20,1,1) ,mean(Ko20,1)+std(Ko20,1,1),'.')
% hold on
p3= plot(intensityValues,mean(noise2,1)./nodiscmean,'Color',color4);
errorbar(intensityValues(:,1:8:end),mean(noise2(:,1:8:end),1)./nodiscmean,std(noise2(:,1:8:end)./nodiscmean,1,1),'.','MarkerSize',1,'Color',color4);

p5 = plot(intensityValues,nonoise./nodiscmean,'Color',color2);
p6 = plot(intensityValues,nodisc./nodiscmean,'Color',color3);

xlim([0 255])
%title('Ordered tauc 20')
legend([p1 p3 p5 p6],'Noise mean = 1','Noise mean = 3','no noise','no discretisation')
% legend([p1 p5 p6],'Noise mean = 1','no noise','no discretisation')
xlabel('Mean intensity')
ylabel('Normalized mean local contrast')

% prompt = 'max y lim? ';
% x = input(prompt);
% ylim([0 x])
end

