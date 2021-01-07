% Fifth Tutorial
clear all; close all; clc;
 
load 'emg'; % Load the EMG signal
fs = 1600; % Sampling frequency
L = length(emg); % Duration of the signal in samples
time_ax=[0:1/fs:(L-1)/fs]; % Time axis of the signal in seconds
 
fc = 5; % Filter cut-off frequency in (Hz)
wc = 2*fc/fs*pi; % Normalized cut-off frequency
 
% Generate Sinc function with a given sampling rate
t = -floor(L):floor(L); % Form the time axis of the Sinc function (theoretically it can be infinetly long)
sinc_func=(wc/pi)*sinc((2*fc/fs)*t);
 
figure; plot(t, sinc_func);
title('Sinc function');
xlabel('n');
ylabel('AU');
 
f_snc=fftshift(fft(sinc_func)); % Find the DFT of the sinc function 
f_ax =(-pi+pi/length(sinc_func):2*pi/length(sinc_func):pi-pi/length(sinc_func))./pi; % Frequency axis for the DFT of sinc function
 
figure; plot(f_ax,f_snc);
title('Discrete time Fourier transform of the Sinc');
xlabel('Frequency (rad)')
ylabel('AU');
 
% Create the FIR filter by truncating the very long sinc function and by using
% one of the following windows: hanning (hann) and rectangular (rectwin);
FIR_duration=1000;
truncation_section=floor(length(sinc_func)/2-FIR_duration/2):floor(length(sinc_func)/2+FIR_duration/2);
fir_filt = sinc_func(truncation_section).*hann(length(truncation_section))'; 
figure;
hold on
freqz(fir_filt);title('FIR filter');
FIR_duration=1000;
truncation_section=floor(length(sinc_func)/2-FIR_duration/2):floor(length(sinc_func)/2+FIR_duration/2);
fir_filt = sinc_func(truncation_section).*rectwin(length(truncation_section))'; 
freqz(fir_filt)
hold off
 
% Create moving avarege filter with the lenght of MA_coef_num
MA_coef_num=1000;
MA = ones(1,MA_coef_num)/MA_coef_num;
 
figure;freqz(MA); title('MA filter');
% Filter the rectified EMG using FIR filter
figure;
hold on
emg  = abs(emg);
env_FIR=conv(emg, fir_filt);
fin = length(env_FIR) - length(fir_filt)/2;
env_FIR = env_FIR((length(fir_filt)/2):fin);
plot(time_ax, env_FIR)

FIR_duration=1000;
truncation_section=floor(length(sinc_func)/2-FIR_duration/2):floor(length(sinc_func)/2+FIR_duration/2);
fir_filt = sinc_func(truncation_section).*hann(length(truncation_section))';
env_FIR=conv(emg, fir_filt);
fin = length(env_FIR) - length(fir_filt)/2;
env_FIR = env_FIR((length(fir_filt)/2):fin);
plot(time_ax, env_FIR)

% Filter the rectified EMG using moving avarage filter
%env_MA = conv(emg, MA);
%fin = length(env_MA) - length(MA)/2;
%env_MA = env_MA((length(MA)/2):fin);
%plot(time_ax, env_MA)

grid minor;
legend('FIR Hanning Envelope', 'FIR Rect Envelope');
xlabel('Time s');
ylabel('EMG Envelope AU');
title('FIR filter using hanning and rectangular window at filter length 400')