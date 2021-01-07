% Eighth tutorial.
close all; clear all; clc
 
load('spike_neural.mat') % Load the neural_sig signal
L = length(neural_sig); % Duration of the signal in samples
fs = 10240; % Sample frequency in Hz
WinSize = [0.2:0.1:2]; % Window size in seconds 
WinSize = round(WinSize.*fs); % Window size in samples
 
f_ax = (-pi:2*pi/fs:pi-2*pi/fs)./(2*pi).*fs; % Frequency axis in Hz
variance_periodogram_estimate = [];
for uu = 1 : length(WinSize)
    
    % Estimate of the periodogram
    window = rectwin(WinSize(uu))';
    for n = 1:35 %For each window length, estimate the periodogram for the first 35 signal segments
        wind_signal=neural_sig((n-1)*WinSize(uu)+(1:WinSize(uu))).*window;
        Segm_spect{uu}(n,:) = fftshift(abs(fft(wind_signal,fs)).^2)./WinSize(uu);
    end    
    
    %Variance of the periodogram estimate for each window size
    variance_periodogram_estimate = [variance_periodogram_estimate var(Segm_spect{uu})'];
 
end


%[Here please complete with instructions for plotting the mean periodogram for rectangular window sizes of 0.2 s, 0.5 s, and 2 s] 


%[Here please complete with instructions for computing the bias for rectangular window sizes of 0.2 s, 0.5 s, and 2 s] 


%[Here please complete with instructions for  plotting variance of estimation of the periodogram as a function of the window size, for rectangular, Hanning, and Hamming windows] 
%Variance of estimation of periodogram as a function of window size for rectangular window
%figure; boxplot(Please fill)
%xlabel(Please fill)
%ylabel(Please fill)
%title(Please fill)

%hanning window
%Please fill

%hamming window
%Please fill
