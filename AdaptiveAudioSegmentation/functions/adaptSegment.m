function [segments,distA,distF,distance] = adaptSegment(audioSignal,window,wA,wF,winPerc,step)
%% Adaptive segmentation of audio signal
resetVariables(); % resets all the variables -> maybe when adSeg is a function this is unnecessary
Threshold = 1;
n = 1;
i = 1;
endflag = 0;
segments(n) = 1;
lagW = window+1:window+1+winPerc*window;       %window size that we consider in the autocorrelation

while(segments(n)+window < length(audioSignal)) %loop until it reaches the end of input
    s = 1;              % reset steps of moving window
    distance(i) = 0;    % init next element in distance
    
    % Reference window
    [ref,lagsR] = xcorr(audioSignal(segments(n):(segments(n)+window)));
    [refP,refN] = splitCurves(ref,lagW); % splits the autocorrelation to positive and negative
    
    while(distance(i) < Threshold)   % loops until the distance hits the threshold
        if(segments(n)+window+s < length(audioSignal)) % if there is room to iterate
            i = i+1;
            
            % Moving window
            [mov,lagsM] = xcorr(audioSignal(segments(n)+s:segments(n)+s+window));
            [movP,movN] = splitCurves(mov,lagW);  % splits the autocorrelation to positive and negative
            
            % Calculate the amplitude distance
            distA(i) = abs(sqrt(max(mov))-sqrt(max(ref)))/min(sqrt(max(ref)),sqrt(max(mov)));
            
            % Calculate the spectral distance
            distF(i) = handStand(refP,refN,movP,movN);
        
            % Calculate the weighted distance
            distance(i) = distA(i)/wA + distF(i)/wF;
            
            s = s+step;      % Step with the moving window
            
            disp(segments(n)+s) % info display
            
        else    % No more steps to iterate
            disp('Reached the end')
            endFlag = 1;
            break
        end
    end
    if(endflag == 0) % a new segment found except when it reached the end of the input 
        n = n+1;                        % step to new segment
        segments(n) = segments(n-1)+s;  % save the location
    end
end
end

function resetVariables()
ref = 0;
refP = 0;
refN = 0;
lagsR=0;
mov =0;
movP =0;
movN =0;
lagsM =0;
distA =0;
c =0;
B =0;
distF =0;
distance = 0;
segStart =0;
window =0;
n=0;
s=0;
i=0;
end
function [pos,neg] = splitCurves(autoCorrSignal,lagWindow)
% pos: take the positive half of the normalized autocorrelation 
pos = autoCorrSignal/max(autoCorrSignal);           % normalize
pos(pos<0) = 0;                                     % cut off negative 
pos = pos(lagWindow);                               % take only length of interest
            
% neg: same thing but for the flipped negative part
neg = -autoCorrSignal/max(autoCorrSignal);          % flip and normalize
neg(neg<0) = 0;                                     % cut off negative
neg = neg(lagWindow);                               % take only length of interest 
end

function spectralDistance = handStand(refPos,refNeg,movPos,movNeg)
% Common area
C = sum(min([refPos',movPos'],[],2)) + sum(min([refNeg',movNeg'],[],2));
% Area Between the two curves
B = sum(max([refPos',movPos'],[],2) - min([refPos',movPos'],[],2)) + sum(max([refNeg',movNeg'],[],2)-min([refNeg', movNeg'],[],2));
spectralDistance = B/C;
end