function [ epo ] = proc_epoching( eeg, varargin )
%PROC_EPOCHING Summary of this function goes here
%   Detailed explanation goes here
if ~varargin{end}
    varargin=varargin{1,1}; %cross-validation procedures
end;

if length(varargin)>1; param=opt_proplistToCell(varargin{:});end

epo=struct('fs',eeg.fs, 'x',[],'y',eeg.mrk.y,'y_logical',eeg.mrk.logical_y);
if isfield(eeg, 'stack')
epo.stack=eeg.stack;
end
% epo.chan=eeg.hdr.chan;

epo.class=eeg.mrk.dClasses;
fs=eeg.fs;

if length(varargin)<2  %default parameter
    ival=varargin{1};
    idc= floor(ival(1)*fs/1000):ceil(ival(2)*fs/1000);
    T= length(idc);
    nEvents= size(eeg.mrk.y, 2);
    nChans= length(eeg.hdr.chan);
    % round
    IV= round(idc(:)*ones(1,nEvents) + ones(T,1)*eeg.mrk.t);
    epo.x= reshape(eeg.x(IV, :), [T, nEvents, nChans]);
    epo.t= linspace(ival(1), ival(2), length(idc));
else
    switch param{1}
        case 'interval'
            ival=param{2};
            idc= floor(ival(1)*fs/1000):ceil(ival(2)*fs/1000);
            T= length(idc);
            nEvents= size(eeg.mrk.y, 2);
           [nDat nChans]=size(eeg.x);
            % round
            IV= round(idc(:)*ones(1,nEvents) + ones(T,1)*eeg.mrk.t);
            epo.x= reshape(eeg.x(IV, :), [T, nEvents, nChans]);
            epo.t= linspace(ival(1), ival(2), length(idc));
    end
end

% stack
c = mfilename('fullpath');
c = strsplit(c,'\');
epo.stack{end+1}=c{end};
end

