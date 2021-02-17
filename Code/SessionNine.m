% Ninth tutorial.
close all; clear all; clc
 
load('spike_neural3.mat') % Load the neural_sig signal
fs = 10240; % Sample frequency in Hz
WinSize = [0.1:0.1:1]; % Window size in seconds
WinSize = round(WinSize.*fs); % Window size in samples
OverlapValues = [0 0.50];
 
Bias_Estimate_Rectangular = zeros(numel(WinSize),numel(OverlapValues));
Bias_Estimate_Hanning = zeros(numel(WinSize),numel(OverlapValues));
Var_Estimate_Rectangular = zeros(numel(WinSize),numel(OverlapValues));
Var_Estimate_Hanning = zeros(numel(WinSize),numel(OverlapValues));


 
for uu = 1 : length(WinSize)
   
    overlap_count=1;
    for Overlap=OverlapValues % size of overlap in percents of window size
        %Rectangular window type
        [periodogram,var_estimate,bias] = welch_periodogram(neural_sig, WinSize(uu), Overlap, 'rect', fs );
        Bias_Estimate_Rectangular(uu,overlap_count) = bias;
        Var_Estimate_Rectangular(uu,overlap_count) = median(var_estimate);  
        %Hanning window type
        [periodogram,var_estimate,bias] = welch_periodogram(neural_sig, WinSize(uu), Overlap, 'hann', fs );
        Bias_Estimate_Hanning(uu,overlap_count) = bias;
        Var_Estimate_Hanning(uu,overlap_count) = median(var_estimate);
       
        overlap_count = overlap_count + 1;
    end
 
end

%Plots for the bias of the estimate for different window types and overlaps over different window sizes
WinSize = [0.1:0.1:1];
figure; hold on;
title('Bias of the estimate against window size for different window types and overlap %')
plot(WinSize, Bias_Estimate_Rectangular(:,1),'b');
plot(WinSize, Bias_Estimate_Rectangular(:,2),'g-.');
plot(WinSize, Bias_Estimate_Hanning(:,1),'c');
plot(WinSize, Bias_Estimate_Hanning(:,2),'k-.');
xlabel('Window size (s)');
ylabel('Bias (AU)');
legend('Rectangular @ 0%', 'Rectangular @ 50%', 'Hanning @ 0%', 'Hanning @ 50%');

 
% Plots for the variability of the estimate for different window types and overlaps over different window sizes
figure; hold on;
title('Variability of the estimate against window size for different window types and overlap %')
plot(WinSize, Var_Estimate_Rectangular(:,1),'b');
plot(WinSize, Var_Estimate_Rectangular(:,2),'g-.');
plot(WinSize, Var_Estimate_Hanning(:,1),'c');
plot(WinSize, Var_Estimate_Hanning(:,2),'k-.');
xlabel('Window size (s)');
ylabel('Variability (AU)');
legend('Rectangular @ 0%', 'Rectangular @ 50%', 'Hanning @ 0%', 'Hanning @ 50%');



function [periodogram,var_estimate,bias] = welch_periodogram(Data, WindowSize, Overlap, WindowType, fs )
   % Estimate of the periodogram
    L = length(Data); % Duration of the signal in samples
    f_ax = (-pi:2*pi/fs:pi-2*pi/fs)./(2*pi).*fs; % Frequency axis in Hz
    variance_periodogram_estimate = [];
   
   
   
   if strcmp(WindowType,'rect')
       window = rectwin(WindowSize)';
   elseif strcmp(WindowType,'hann')
       window =  hann(WindowSize)';
    end
   
      n=1;
    while max(round((n-1)*WindowSize*(1-Overlap))+(1:WindowSize))<=L
        index=round((n-1)*WindowSize*(1-Overlap))+(1:WindowSize);
        wind_signal= Data(index).*window;
        Segm_spect(n,:) = fftshift(abs(fft(wind_signal,fs)).^2)./WindowSize;
        n=n+1;
    end    
   
    periodogram = mean(Segm_spect);
    var_estimate = [variance_periodogram_estimate var(Segm_spect)'];
    bias_period = mean(Segm_spect);
    bias_interest = bias_period(5115:5126);
    area = trapz (bias_interest);
    bias = area/bias_period(5121);
   
   
    %%figure; plot(f_ax,periodogram);
end
