% Sixth tutorial.
close all; clear all; clc
 
load('EMG1.mat'); % Load the EMG signal
L = length(EMG); % Duration of the signal in samples
 
Fs = 2500; % Sample frequency in Hz
t_ax = (0:L-1)/Fs; % Time axis of the signal in seconds
 
figure(1), plot(t_ax,EMG)
title('Intramuscular EMG signal')
xlabel('Time [s]')
ylabel('AU')
 
F_EMG = fftshift(fft(EMG)); % Find the DFT of the EMG 
f_ax = (-L/2:L/2-1)*Fs/L;
figure(2), plot(f_ax,abs(F_EMG));
xlabel('Frequency (Hz)')
ylabel('Magnitude AU')
title('Spectrum of the signal before the filtering')
 
% Create band-stop filters to remove 60 Hz and harmonics
N = 3; % Filter order
band1 = [58 62];
[B1,A1] = butter(N,band1/(Fs/2),'stop'); % Generate filter coefficients
band2 = [118 122];
[B2,A2] = butter(N,band2/(Fs/2),'stop');
band3 = [178 182];
[B3,A3] = butter(N,band3/(Fs/2),'stop');
 
% Analyze the properties of the filter
H1 = tf(B1,A1,1/Fs,'variable','z^-1'); % Create transfer function object
[z,p,k] = tf2zp(B1,A1); % Calculate zeros and poles
figure(3), freqz(B1,A1);
title('Analysis in frequency domain of the filter that remove 60Hz-band frequency ')
figure(4), zplane(B1,A1);
title('z-plane to represent zeros and poles of 60Hz-band frequency filter')
 
H2 = tf(B2,A2,1/Fs,'variable','z^-1'); % Create transfer function object
[z,p,k] = tf2zp(B2,A2); % Calculate zeros and poles
figure(5), freqz(B2,A2);
title('Analysis in frequency domain of the filter that remove 120Hz-band frequency ')
figure(6), zplane(B2,A2);
title('z-plane to represent zeros and poles of 120Hz-band frequency filter')

H3 = tf(B3,A3,1/Fs,'variable','z^-1'); % Create transfer function object
[z,p,k] = tf2zp(B3,A3); % Calculate zeros and poles
figure(7), freqz(B3,A3);
title('Analysis in frequency domain of the filter that remove 180Hz-band frequency ')
figure(8), zplane(B3,A3);
title('z-plane to represent zeros and poles of 180Hz-band frequency filter')

% Filter the signal
figure(9), hold on, plot(t_ax,EMG,'b'); %original signal
 
EMG_f = filter(B1,A1,EMG);
figure(9), hold on, plot(t_ax,EMG_f,'r');
 
EMG_f2 = filter(B2,A2,EMG_f);
plot(t_ax,EMG_f2,'r');

EMG_f3 = filter(B3,A3,EMG_f2);
hold off 
plot(t_ax,EMG_f3,'r');



% DFT of the filtered signal
F_EMG_f = fftshift(fft(EMG_f));
figure(10);
plot(f_ax, abs(F_EMG_f));
xlabel('Frequency (Hz)')
ylabel('Magnitude AU')
title('Spectrum of the signal after first filtering of 60Hz')

F_EMG_f2 = fftshift(fft(EMG_f2));
figure(11);
plot(f_ax, abs(F_EMG_f2));
xlabel('Frequency (Hz)')
ylabel('Magnitude AU')
title('Spectrum of the signal after second filtering of 120Hz')

F_EMG_f3 = fftshift(fft(EMG_f3));
figure(12);
plot(f_ax, abs(F_EMG_f3));
xlabel('Frequency (Hz)')
ylabel('Magnitude AU')
title('Spectrum of the signal after third filtering of 180Hz')
