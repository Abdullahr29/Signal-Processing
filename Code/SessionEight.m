% Eighth tutorial.
close all; clear all; clc
 
 
 
load('spike_neural2.mat') % Load the neural_sig signal
 
L = length(neural_sig); % Duration of the signal in samples
 
fs = 10240; % Sample frequency in Hz
 
WinSize = [0.2:0.1:2]; % Window size in seconds 
 
WinSize = round(WinSize.*fs); % Window size in samples
 
 
 
f_ax = (-pi:2*pi/fs:pi-2*pi/fs)./(2*pi).*fs; % Frequency axis in Hz
 
variance_periodogram_estimate = [];

variance_periodogram_estimate2 = [];

variance_periodogram_estimate3 = [];
 
 
 
meanVect = zeros(length(WinSize),10240);
 
meanVect2 = zeros(length(WinSize),10240);
 
meanVect3 = zeros(length(WinSize),10240);
 
 
 
areaVect = zeros(length(WinSize));
 
areaVect2 = zeros(length(WinSize));
 
areaVect3 = zeros(length(WinSize));
 
 
 
 
 
for uu = 1 : length(WinSize)
 
    
 
    % Estimate of the periodogram
 
    window = rectwin(WinSize(uu))';
 
    window2 = hann(WinSize(uu))';
 
    window3 = hamming(WinSize(uu))';
 
    
 
    for n = 1:35 %For each window length, estimate the periodogram for the first 35 signal segments
 
        wind_signal=neural_sig((n-1)*WinSize(uu)+(1:WinSize(uu))).*window;
 
        wind_signal2=neural_sig((n-1)*WinSize(uu)+(1:WinSize(uu))).*window2;
 
        wind_signal3=neural_sig((n-1)*WinSize(uu)+(1:WinSize(uu))).*window3;
 
        
 
        Segm_spect{uu}(n,:) = fftshift(abs(fft(wind_signal,fs)).^2)./WinSize(uu);
 
        Segm_spect2{uu}(n,:) = fftshift(abs(fft(wind_signal2,fs)).^2)./WinSize(uu);
 
        Segm_spect3{uu}(n,:) = fftshift(abs(fft(wind_signal3,fs)).^2)./WinSize(uu);
 
    end    
 
    
 
    %Variance of the periodogram estimate for each window size
 
    variance_periodogram_estimate = [variance_periodogram_estimate var(Segm_spect{uu})'];
 
    variance_periodogram_estimate2 = [variance_periodogram_estimate2 var(Segm_spect2{uu})'];
 
    variance_periodogram_estimate3 = [variance_periodogram_estimate3 var(Segm_spect3{uu})'];
    
    
 
    for i=1:10240
 
        meanVect(uu, i) = mean(Segm_spect{uu}(:,i));
 
        meanVect2(uu, i) = mean(Segm_spect2{uu}(:,i));
 
        meanVect3(uu, i) = mean(Segm_spect3{uu}(:,i));
 
    end
 
 
 
    for i=5116:5126
 
        areaVect(uu) = areaVect(uu) + meanVect(uu,i);
 
        areaVect2(uu) = areaVect2(uu) + meanVect2(uu,i);
 
        areaVect3(uu) = areaVect3(uu) + meanVect3(uu,i);
 
    end
 
    
 
    areaVect(uu) = areaVect(uu)/meanVect(uu,5121);
 
    areaVect2(uu) = areaVect2(uu)/meanVect2(uu,5121);
 
    areaVect3(uu) = areaVect3(uu)/meanVect3(uu,5121);
 
end
 
figure(2);



vars = variance_periodogram_estimate';

for i=1:19
    g(i,1) = i*ones(size(vars(i)));
end

boxplot(variance_periodogram_estimate,g)
title("Variance in estimation of periodogram against window size for rectangular window");
ylabel("Variance (AU)");
xlabel("Window size (s)");
figure(3)

vars2 = variance_periodogram_estimate2';

for i=1:19
    g(i,1) = i*ones(size(vars2(i)));
end

boxplot(variance_periodogram_estimate2,g)
title("Variance in estimation of periodogram against window size for hanning window");
ylabel("Variance (AU)");
xlabel("Window size (s)");
 figure(4)
 
 vars3 = variance_periodogram_estimate3';

for i=1:19
    g(i,1) = i*ones(size(vars3(i)));
end

boxplot(variance_periodogram_estimate3,g)
title("Variance in estimation of periodogram against window size for hamming window");
ylabel("Variance (AU)");
xlabel("Window size (s)");
%% Mean periodogram for rectangular window sizes of 0.2 s, 0.5 s, and 2 s
 
index1 = 1;
 
index2 = 4;
 
index3 = 19;
 
mean1 = zeros(1,35);
 
mean2 = zeros(1,35);
 
mean3 = zeros(1,35);
 
 
 
for i = 1:10240
 
    mean1(i) = mean(Segm_spect{index1}(:,i));
 
    mean2(i) = mean(Segm_spect{index2}(:,i));
 
    mean3(i) = mean(Segm_spect{index3}(:,i));
 
end
 
 
 
figure


 
subplot(3,1,1)
 
plot(f_ax,mean1,'b');
 
xlabel("Frequency (Hz)"), ylabel("AU")
 
title("Mean periodogram for rectangular window of size 0.2s")

xlim([-50, 50]);
 
subplot(3,1,2)
 
plot(f_ax,mean2,'b');
 
xlabel("Frequency (Hz)"), ylabel("AU")
 
title("Mean periodogram for rectangular window of size 0.5s")
xlim([-50, 50]);
 
subplot(3,1,3)
 
plot(f_ax,mean3,'b');
 
xlabel("Frequency (Hz)"), ylabel("AU")
 
title("Mean periodogram for rectangular window of size 2s")
xlim([-50, 50]);


 

 