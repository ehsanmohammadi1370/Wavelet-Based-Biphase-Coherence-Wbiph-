%  The Wbiph function extracts wavelet-based biphase coherency from two EEG channels.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% date , 22.08.2023:
% Inputs: x : first EEG channel data;
% Inputs: y : second EEG channel data;
% Inputs: wname: wavelet name;
% Inputs: scale: the scales for wavelet. see help 'cwt';
% Outputs: pic: a matrix that contains extracted wavelet-based biphase coherencies.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ehsan_bifreq_func Function, Coded by Ehsan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Example :write this code in the command window then see the result variable
% clc;clear;close all;
% load first EEG channle data in vector x
% load second EEG channle data in vector y 
% wname='cgau4';Fs=your desired sampling frequency
% ff=[your desired frequencies];scale=Fs*0.5 ./ ff;
% [pic] = ehsan_bifreq_func(x,y,wname,scale);
% then see matrix pic;


function [pic] = ehsan_bifreq_func(x,y,wname,scale)
ccfs1 = cwt(x,scale,wname);
ccfs2 = cwt(y,scale,wname);
for s1 = 1 : length(scale)
    for s2 = s1 :length(scale)
        v1(s1,s2,:)= ccfs1(s1,:).*ccfs1(s2,:).*ccfs1(floor((s1*s2/(s1+s2))+0.5),:);
        v2(s1,s2,:)= ccfs2(s1,:).*ccfs2(s2,:).*ccfs2(floor((s1*s2/(s1+s2))+0.5),:);
        PHI_X1(s1,s2,:)=angle(v1(s1,s2,:));PHI_X1(s2,s1,:)=PHI_X1(s1,s2,:);
        PHI_X2(s1,s2,:)=angle(v2(s1,s2,:));PHI_X2(s2,s1,:)=PHI_X2(s1,s2,:);
    end
end
aa=PHI_X1 .* PHI_X2; 
pic= mean(aa,3);


end

