function [ out ] = func_featureExtraction( in, varargin )
%PROC_FEAEXTRACTION Summary of this function goes here
%   Detailed explanation goes here
if ~varargin{end}
    varargin=varargin{1,1}; %cross-validation procedures
end;

param=opt_proplistToCell(varargin{:});

if length(param)<2;n=1;
else n=2;
end

if isstruct(in)
    dat=in.x;
else
    dat=in;
end

switch lower(param{n})
    case 'logvar'
        dat=squeeze(log(var(dat)));
end


if isstruct(in)
    in.x=dat;
else
    in=dat;
end
out=in;

if isfield(in,'stack') %% put in the function
    % stack
    c = mfilename('fullpath');
    c = strsplit(c,'\');
    in.stack{end+1}=c{end};
end
end

