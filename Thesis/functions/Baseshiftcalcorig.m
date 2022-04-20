function [A,M_vec,M_spm,U_spm] = Baseshiftcalcorig(W,dr) 
%BASESHIFTCALC Baseshift and least squares fit
mVol = length(dr);

M = zeros(4,4,mVol);
for v = 1:mVol %recreate M with zero mean and unit variance
        M(:,:,v) = spm_matrix([dr(:,v);1;1;1;0;0;0]);
end

M_vec = zeros(12,mVol);
for v = 1:mVol
    M_tmp = M(:,:,v); 
    M_tmp = M_tmp-eye(4);
    M_tmp(4,:) = []; % remove last row because it is always 0 0 0 1. Substract eye(4) so diag is 0 in M{1}
    M_vec(:,v) = M_tmp(:);
end

[U_spm,S,V] =  svd(M_vec,'econ'); %SVD
M_spm = S*V';

A = M_spm / W; %Least squares fit

end

