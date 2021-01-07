% Third tutorial
clear all
close all
clc
 
% Signal loading
load('EEG.mat');
 
% Sampling frequency
fsamp = 512;
 
% Select duration to analyze
Duration = 1; % Duration in seconds (max 15 seconds)
Duration = round(Duration*fsamp);
EEG = EEG(1:Duration); 
 
% Signal duration in samples
L = length(EEG);
 
% Plot the EEG signal
time_ax = [0:L-1]./fsamp;
figure(1)
plot(time_ax, EEG);
xlabel('Time (s)')
title(['EEG signal'])
ylabel('Amplitude EEG (Arbitrary Units)')
 
% Compute DFT of the channel
X1 = fft( EEG - mean(EEG) );
 
% Compute PSD (power spectral density) of the two channels and adjust
% frequency axis according to Matlab notation
PSD1 = fftshift(abs(X1).^2)/L;
 
% Build the frequency axis in radiants
freq_a_rad = [-pi+pi/L:2*pi/L:pi-pi/L];
% Convert the frequency axis in Hz
freq_a_Hz = freq_a_rad./(2*pi).*fsamp;
 
% Plot the PSD of the channel with frequencies in radiants and Hz
figure(2), subplot(2,1,1), plot(freq_a_rad,PSD1);
xlabel('Frequency (radians)')
title('Power Spectral Density of EEG for interval of 15s')
ylabel('PSD (Arbitrary Units)')

figure(2), subplot(2,1,2), plot(freq_a_Hz,PSD1);
xlabel('Frequency (Hz)')
title('Power Spectral Density of EEG for interval of 15s')
ylabel('PSD (Arbitrary Units)')
 
%% Compute the percentage of power in different subbands
%[Here please complete with instructions for computing the relative power in the frequency bands.]
%Delta (from 0.5 to 4 Hz), Theta (4 to 8 Hz), Alpha (8 to 13 Hz), Beta (13 to 30 Hz), and Gamma (30 to 42 Hz). 
k1 = 0.5;
k2 = 4;
total = 0;
totalPSD = 0;

for i = 1:L
    if freq_a_Hz(i)>= k1 && freq_a_Hz(i)<= k2
        total = total + PSD1(i);
    end
end

for i = 1:(L/2)
    totalPSD = totalPSD + PSD1(i);
end

total = (total/totalPSD)*100;
fprintf("Percent power for theta at 5s is: " + total + "\n");

    
    
    
    
    
    
    
    
    
    
 