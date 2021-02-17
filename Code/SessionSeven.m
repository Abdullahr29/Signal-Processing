% Seventh tutorial.
close all; clear all; clc
 
load('EEG4.mat') % Load the EEG signal
fs = 200; % Sample frequency in Hz
L = length(EEG); % Duration of the signal in samples
 
winStep = 0.025; % window size increase in seconds
winSizeVector = floor([1:(L)/(winStep*fs)]*winStep*fs); % Vector containing window sizes ranging in 25ms step increases 
 
% Iterate over different window lengths to compute the estimations of mean
% and variance
for iter_winSize = 1:numel(winSizeVector)
    % calculate the remaining values for the same window size
    for iterSig=1:floor((length(EEG))/winSizeVector(iter_winSize))
        start_idx=(iterSig-1)*winSizeVector(iter_winSize)+1; %starting sample index of the extracted window
        end_idx = iterSig*winSizeVector(iter_winSize); %ending sample index of the extracted window
        V_fixWin(iterSig) = var(EEG(start_idx:end_idx));% Calculate variance for the given window length
        M_fixWin(iterSig) = mean(EEG(start_idx:end_idx));% Calculate mean for the given window length
    end
    V{iter_winSize,:} = V_fixWin;% store variance for the given window length
    M{iter_winSize,:} = M_fixWin;% store mean for the given window length
    
    V_avg(iter_winSize) = mean(V_fixWin);% calculate the mean value of the variance for the given window length
    M_avg(iter_winSize) = mean(M_fixWin);% calculate the mean value of the mean for the given window length
        
    V_fixWin=[];
    M_fixWin=[];
end
%%
winSizeIdx=40;
x_axis=[1:length(V{winSizeIdx,:})].*(winSizeVector(winSizeIdx)/fs);
figure, plot(x_axis,V{winSizeIdx,:},'r','LineWidth',0.5);
xlabel('Time [s]'), ylabel('[AU]')
title('Estimate of the variance for window length of 1s')
VarV = var(V{winSizeIdx,:})

%[Here please complete with instructions for plotting the Estimates of the mean for the given fixed window length] 
x_axis=[1:length(M{winSizeIdx,:})].*(winSizeVector(winSizeIdx)/fs);
figure, plot(x_axis,M{winSizeIdx,:},'b','LineWidth',0.5);
xlabel('Time [s]'), ylabel('[AU]')
title('Estimate of the mean for window length of 1s')
VarM = var(M{winSizeIdx,:})

x_ax_length = [1:(L)/(winStep*fs)]*winStep; %build the x axis for the plot
% Plot the variance with respect to the window length
figure, plot(x_ax_length,V_avg,'c','LineWidth',0.5),hold on
xlabel('Duration of the windows [s]'), ylabel('[AU]')
title('Values of variance against window size s')

%[Here please complete with instructions for plotting the values of means depending on the window size] 
figure, plot(x_ax_length,M_avg,'b','LineWidth',0.5),hold on
xlabel('Duration of the windows [s]'), ylabel('[AU]')
title('Values of mean against window size s')


figure
histogram(EEG,'Normalization','probability');
xlabel('Bins'), ylabel('[AU]')
title('PDF of the random process')

