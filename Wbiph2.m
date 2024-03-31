%  The Wbiph2 function extract wavelet based biphase coherency
% from tow EEG channles .
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% date , 22.08.2023:
% Inputs: x : first EEG channle data;
% Inputs: y : second EEG channle data;
% Inputs: wname : wavelet name;
% Inputs: scale : the scales for wavelet. see help 'cwt';
% Outputs: pic: a vector that contains extracted wavelet based biphase coherencies.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ehsan_bifreq_func2 Function,Coded by Ehsan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%example :write this code in command window then see the result variable
% clc;clear;close all;
% load('new2_nA01.mat')
% X=data_new{1};clear('data_new');
% x=X(1,:);y=X(2,:);
% wname='cgau4';Fs=250;
% ff=[2 4 6 8 10 12 14 16 18 20 24 28 32 36 40 50 60 70 80];scale=Fs*0.5 ./ ff;
% [pic] = ehsan_bifreq_func2(x,y,wname,scale);
% then see vector pic;

function [pic] = ehsan_bifreq_func2(x,y,wname,scale)
ccfs1 = cwt(x,scale,wname);pic=[];
ccfs2 = cwt(y,scale,wname);
cnt=0;
for s1 = 1 : length(scale)
    for s2 = s1 :length(scale)
        cnt=cnt+1;
        v1= ccfs1(s1,:).*ccfs1(s2,:).*ccfs1(floor((s1*s2/(s1+s2))+0.5),:);
        v2= ccfs2(s1,:).*ccfs2(s2,:).*ccfs2(floor((s1*s2/(s1+s2))+0.5),:);
        PHI_X1=angle(v1);PHI_X2=angle(v2);
        pic(cnt)=mean(PHI_X1.* PHI_X2);
        
    end
end
end

