function [rLin,interM] = Baseshiftapplyorig2(W,A,U_spm)
%BASESHIFTAPPLY 

[~,nVol] = size(W,[1 2]);

rLin = zeros(12,nVol);
M = zeros(12,nVol);

for v=1:nVol

    M(:,v) = pinv(A)* W(:,v);

    interM(:,:,v) = cat(1, reshape(( U_spm*M(:,v))',[3 4] ),[0 0 0 0] ) + eye(4);
    rLin(:,v) = spm_imatrix(interM(:,:,v)); 
end
rLin = rLin (1:6,:);


end

