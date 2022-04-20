function plotIt(signal,fs,segments,distance,distA,distF,wA,wF,step,expectedSegments)
x = (1:length(signal))/fs;
xD = (1:length(distance))/fs*step;

figure()
subplot(3,1,1)
plot(x,signal)
hold on
for i = 2:(length(segments)-1)
    xline(segments(i)/fs,'-.r','LineWidth',2)
end
if nargin == 10
    % expectedSegments
    for i = 1:length(expectedSegments)
        xline(expectedSegments(i)/fs,'-.b','LineWidth',2)
    end
end

hold off
ylabel('Amplitude')
xlim([0 length(signal)/fs])
xt = xticks;

subplot(3,1,2)
plot(xD,distance)
hold on
plot(xD,distA/wA)
plot(xD,distF/wF)
hold off
xlim([0 length(signal)/fs])
xticks(xt)
ylabel('Distance')
legend('D','A','F')

subplot(3,1,3)
% spectrogram(signal,128,120,128,fs,'Yaxis')
% xlabel('Time[s]')
[~,F,T,P] = spectrogram(signal,128,120,128,fs,'yaxis');
imagesc(T, F, 10*log10(P+eps)) % add eps like pspectrogram does
axis xy
ylabel('Frequency (Hz)')
xlabel('Time (s)')
h = colorbar;
h.Label.String = 'Power/frequency (dB/Hz)';
xticks(xt)
end