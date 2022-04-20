clear all
addpath('functions')
addpath('Data')

%  load meanintensity110
load meanintensity110P01
% load meanintensity25
% load meanintensity200

%% calculate contrasts (local mean)
tic
noisemeanmax = 5;
imageframes1 = O20I110P01;
imageframes2 = O80I110P01;
imageframes3 = B500I110P01;

[o20K1,o20K2,o20K3,o20Knonoise1,o20Knonoise2,o20Knonoise3] = allSpeckleContrast(imageframes1,noisemeanmax);
[o80K1,o80K2,o80K3,o80Knonoise1,o80Knonoise2,o80Knonoise3] = allSpeckleContrast(imageframes2,noisemeanmax);
[BK1,BK2,BK3,BKnonoise1,BKnonoise2,BKnonoise3] = allSpeckleContrast(imageframes3,noisemeanmax);
toc
%% Visualize
titles = {'Large vessel, \tau_{c} = 20'; 'Medium vessel, \tau_{c} = 80'; 'Parenchyma, \tau_{c} = 500'};
figure
t=tiledlayout(1,3,'TileSpacing','none','Padding','compact');
title(t,'Parenchyma contrast = 0.1')
nexttile
noisePlot(o20K1,o20K2,o20K3,o20Knonoise1,o20Knonoise2,o20Knonoise3,noisemeanmax);
title([titles{1},', mean I = 110'])
% ylim([0.95 1.5])
ylim([0.95 2.5])
% ylim([0.6 2])

nexttile
noisePlot(o80K1,o80K2,o80K3,o80Knonoise1,o80Knonoise2,o80Knonoise3,noisemeanmax);
title([titles{2},', mean I = 110'])
% ylim([0.95 1.5])
ylim([0.95 2.5])
% ylim([0.6 2])

nexttile
noisePlot(BK1,BK2,BK3,BKnonoise1,BKnonoise2,BKnonoise3,noisemeanmax);
title([titles{3},', mean I = 110'])
% ylim([0.95 1.05])
ylim([0.95 1.10])
% ylim([0.6 1.2])

%% calculate contrasts (global)
tic
noisemeanmax = 5;
imageframes1 = O20I110P01;
imageframes2 = O80I110P01;
imageframes3 = B500I110P01;

[o20K1,o20K2,o20K3,o20Knonoise1,o20Knonoise2,o20Knonoise3] = allSpeckleGlobalK(imageframes1,noisemeanmax);
[o80K1,o80K2,o80K3,o80Knonoise1,o80Knonoise2,o80Knonoise3] = allSpeckleGlobalK(imageframes2,noisemeanmax);
[BK1,BK2,BK3,BKnonoise1,BKnonoise2,BKnonoise3] = allSpeckleGlobalK(imageframes3,noisemeanmax);
toc


%% pixelCrosstalk
tic
noisemeanmax = 5;
imageframes1 = O20I110P01(:,:,2);
imageframes2 = O80I110P01(:,:,2);
imageframes3 = B500I110P01(:,:,2);

[o20K,o20CT1,o20CT2,o20CT3,o20Knonoise1] = localContrastCrosstalk(imageframes1,noisemeanmax);
[o80K,o80CT1,o80CT2,o80CT3,o80Knonoise1] = localContrastCrosstalk(imageframes2,noisemeanmax);
[BK,BCT1,BCT2,BCT3,BKnonoise1] = localContrastCrosstalk(imageframes3,noisemeanmax);
toc

%% Visualize Crosstalk
titles = {'Large vessel, \tau_{c} = 20'; 'Medium vessel, \tau_{c} = 80'; 'Parenchyma, \tau_{c} = 500'};
figure
tiledlayout(1,3,'TileSpacing','none','Padding','compact')
nexttile
noisePlotCrosstalk(o20K,o20CT1,o20CT2,o20CT3,o20Knonoise1,noisemeanmax);
title([titles{1},', mean I = 110'])
%ylim([0.95 2])

nexttile
noisePlotCrosstalk(o80K,o80CT1,o80CT2,o80CT3,o80Knonoise1,noisemeanmax);
title([titles{2},', mean I = 110'])
%ylim([0.95 2])

nexttile
noisePlotCrosstalk(BK,BCT1,BCT2,BCT3,BKnonoise1,noisemeanmax);
title([titles{3},', mean I = 110'])
%ylim([0.95 1.05])
