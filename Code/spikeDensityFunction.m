function [raster,histogram,pt,SDF]=spikeDensityFunction(spike,trials,event,peritime,KernelType)

%% SPECULATIVE DOCUMENTATION ADDED BY asampson
%  spike should be a cell array of vectors of spike times for each trial
%  trials should be a vector of trial numbers, seems like it should not skip trials (i.e. can be trials 1:10, but not [1 5 10]
%  event should be a #TRIALS X 1 vector of alignment times for each trial
%  peritime should be a two-element vector of pre- and post-aligment time to include
%  KernalType can be 1 for a PSP (post-synaptic potential?) kernal or 2 for a Gaussian kernal

raster=[];histogram=[];SDF=[];
% if ~nargin
%     load('GI-Gollum-06-29-2013','sig003a','NoStopTrials','Move_of_Interest')
%     spike=sig003a;
%     trials=nonzeros(NoStopTrials(:,1));
%     event=Move_of_Interest;
%     peritime=[-1 1];
%     KernelType=2;
% end

if nargin==4
    KernelType=1; % PSP kernel
% elseif nargin == 5                    % asampson edit--just take input value of KernalType
%     KernelType=2; % Gaussian kernel
end

% binsize=0.001;
% binsize = 0.01;
% binsize = 0.1;
binsize=1;
% disp([num2str(length(trials)),' trials'])

%%
for ii = 1:length(trials)
    spike_mat = cell2mat(spike(ii));
    temp = spike_mat(spike_mat>event(trials(ii),1)+peritime(1) ...
        & spike_mat<event(trials(ii),1)+peritime(2));
    raster(ii,1:length(temp))=temp;
end
    temp = nan(size(raster));
    temp(raster>0)=raster(raster>0);
    raster=temp;
for ii = 1:length(trials)
    raster(ii,:)=raster(ii,:)-event(trials(ii),1);
end
pt=peritime(1):binsize:peritime(2);
[histogram,bin]=histc(raster(:),pt);

%%
if KernelType ==1
    Growth=1; Decay=20;
    Half_BW=round(Decay*8);
    BinSize=(Half_BW*2)+1;
    Kernel=[0:Half_BW];
    Half_Kernel=(1-(exp(-(Kernel./Growth)))).*(exp(-(Kernel./Decay)));
    Half_Kernel=Half_Kernel./sum(Half_Kernel);
    Kernel(1:Half_BW)=0;
    Kernel(Half_BW+1:BinSize)=Half_Kernel;
    Kernel=Kernel.*1000;
    Kernel=Kernel';
elseif KernelType ==2
    sigma=30;
    X=-50:50;
    Kernel = 1/(sqrt(2*pi)*sigma)*exp(-0.5*X.^2/(sigma^2));
    Kernel=Kernel/sum(Kernel);
    Kernel=Kernel.*1000;
    Kernel=Kernel';
    npts =length(Kernel);%npts = 50;
end

% close all
% hold on
SDF = (convn(histogram(~isnan(histogram)), Kernel))/length(trials);
SDF(1:ceil(length(Kernel)/2))=[];
SDF=SDF(1:length(histogram));
SDF= SDF(:);
% plot(pt,SDF,'r')
% beep
% close all
% plot(pt,histogram,'r')
