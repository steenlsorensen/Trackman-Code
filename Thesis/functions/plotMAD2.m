function [] = plotMAD2(testTarget,pLin,pNN,svm)
%PLOTMAD plot results of different model fit
%%
testTarget(4:6,:)=rad2deg(testTarget(4:6,:));
pLin(4:6,:)=rad2deg(pLin(4:6,:));
pNN(4:6,:)=rad2deg(pNN(4:6,:));
svm(4:6,:)=rad2deg(svm(4:6,:));


x=1:size(testTarget,2);
titles = {'x translation';'y translation';'z translation';'x rotation';'y rotation';'z rotation'};
figure
t=tiledlayout('flow');
t.TileSpacing = 'compact';
t.Padding = 'compact';
for i = 1:6
    nexttile
    plot(x,testTarget(i,:))
    hold on
    plot(x,pLin(i,:))
    hold on
    plot(x,pNN(i,:))
    plot(x,svm(i,:))
    

    madlin = mean(abs(testTarget(i,:)-pLin(i,:)),2);
    madNN = mean(abs(testTarget(i,:)-pNN(i,:)),2);
    madsvm = mean(abs(testTarget(i,:)-svm(i,:)),2);


    title([titles(i),sprintf('MAD lin: %.2f',madlin),sprintf('MAD NNdiff: %.2f',madNN),sprintf('MAD SVM: %.2f',madsvm)])
   if i<4

        ylim([min([testTarget(1:3,:),pLin(1:3,:),pNN(1:3,:)],[],'all') max([testTarget(1:3,:),pLin(1:3,:),pNN(1:3,:)],[],'all')])
        xlabel('samples')
        ylabel('Translation [mm]')
    else

        ylim([min([testTarget(4:6,:),pLin(4:6,:),pNN(4:6,:)],[],'all') max([testTarget(4:6,:),pLin(4:6,:),pNN(4:6,:)],[],'all')])
        xlabel('samples')
        ylabel('Rotation [deg]')
    end
end
lg  = legend('Target','Linear','NN','SVM'); 
lg.Layout.Tile = 'East'; 

%calculate mean result
meanmadNN = mean(mean(abs(testTarget-pNN),2));
meanmadlin = mean(mean(abs(testTarget-pLin),2));
meanmadSVM = mean(mean(abs(testTarget-svm),2));
disp(['meanmadLin = ',num2str(meanmadlin)])
disp(['meanmadNN = ',num2str(meanmadNN)])
disp(['meanmadSVM = ',num2str(meanmadSVM)])
end

