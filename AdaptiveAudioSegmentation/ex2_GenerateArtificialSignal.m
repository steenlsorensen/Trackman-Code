%% Part 1: Generate an artificial digital signal
addpath FilterParams
%% Initial parameters
% Define random noise
fs = 260; %Hz
signalLength = 150; %sec
samples = fs*signalLength; % nr of samples
x = (1:samples)/fs; %this is useful for plotting with time axis

%% Import filters and generate signals with white noise
% generate 6 different signals, based on different filter params.
% for this part we need to export n .mat files called filterParams+number
% to the same folder
whiteNoise = randn(samples,1);
n = 6;
for i = 1:n
    load(['filterParams' num2str(i) '.mat'])
    [Num,Den] = sos2tf(SOS,G);
    signals(:,i) = filter(Num,Den,whiteNoise);
    subplot(n/2,2,i)
    zplane(Num,Den)
    Den = 0;
    Num  = 0;
    SOS = 0;
    G = 0;
end

%% Stitch the segments to one signal
% generate random lengthed segments
rL = [0; randi([2000 10000], n, 1)]; 
rL = round(cumsum(rL/sum(rL))*length(signals));

% shuffle the different filters
rS = randperm(n);

% stitch the signals
for i = 1:n
    segStart = rL(i)+1;
    segStop = rL(i+1);
    % ads: Artificial digital signal
    ads(segStart:segStop) = signals(segStart:segStop,rS(i)); 
end
% sound(ads); % To play the signal as audio
%% Save signal
save('ads.mat','ads','rL','fs')

%% visualize the generated signal with boundaries
figure()
subplot(2,1,1)
plot(x,ads)
hold on
for i = 2:(length(rL)-1)
    xline(rL(i)/fs,'--b','LineWidth',2)
end
hold off
xlabel('Time[s]')
ylabel('Amplitude')

subplot(2,1,2)
% spectrogram(ads,128,120,128,fs,'Yaxis')
% xlabel('Time[s]')
[~,F,T,P] = spectrogram(ads,128,120,128,fs,'yaxis');
imagesc(T, F, 10*log10(P+eps)) % add eps like pspectrogram does
axis xy
ylabel('Frequency (Hz)')
xlabel('Time (s)')
h = colorbar;
h.Label.String = 'Power/frequency (dB/Hz)';