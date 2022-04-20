function [rLin,M] = Baseshiftapplyorig(W,A,U_spm)

[~,nVol] = size(W,[1 2]);

rLin = zeros(12,nVol);
M=A*W;

for v=1:nVol

    rLin(:,v) = spm_imatrix( cat(1, reshape(( U_spm*M(:,v))',[3 4] ),[0 0 0 0] ) + eye(4)); % concat last row in and add eye(4) back

end
rLin = rLin (1:6,:); 

end

