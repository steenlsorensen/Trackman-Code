%getG2 - calculates normalized intensity autocorrelation
%
% Syntax:  output1 = function_name(input1,input2)
%
% Inputs:
%    data       - raw intensity data as 3d [y,x,t] matrix
%    lagMax     - maximum frame lag 
%
% Outputs:
%    g2        - autocorrelation data as [y,x,lag] 3d matrix
%
% Example:
%    g2=getG2(data,20)
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: DD Postnov, PhD
% BOAS lab, Boston University
% email address: dpostnov@bu.edu
% Last revision: 3-March-2018

%------------- BEGIN CODE --------------

function g2=getG2(data,lagMax)
g2=zeros(size(data,1),size(data,2),lagMax+1,'single');
sampleL=size(data,3)-lagMax;
for lag=0:1:lagMax
    g2(:,:,lag+1)=mean(data(:,:,1:sampleL).*data(:,:,1+lag:sampleL+lag),3);
end
g2=g2./(mean(data,3).^2);
end

%------------- END OF CODE --------------
% Comments: 3rd dim of the input data has to be at least few times larger
%than the lagMax value. 