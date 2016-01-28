function [  ] = send_ppTrigger(byte)
%SEND_PPTRIGGER Summary of this function goes here
%   Detailed explanation goes here
global cogent;
 if( cogent.io.status ~= 0 )
    error('inp/outp installation failed');
 end

global BMI
outp(BMI.IO_ADDR,byte);

end

