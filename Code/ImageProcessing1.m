%% lab 1
clear all; close all; clc;
fid=fopen('head.128','r');
[x,npels]=fread(fid,[128,128],'uchar');  % Reads data values
% into matrix x with 128 rows,
% and 128 columns 
x=x';
fclose(fid); % Close the file handle 
image(x)
mymap = colormap(gray(256));
colorbar

%% 1.5 

clear; close all; % Close all windows, and clear all variables
[X,map] = imread('trees.tif'); 
image(X); % Display the image…
colormap(map); % with its colormap (as read from the TIFF file)
colorbar;


%% 1.6

clear; close all; % Close all windows, and clear all variables
[X,map] = imread('lily.tif'); 
column_ramp = [0:1/255:1]';% Create column of values running from 0 to 1
% The next 3 lines create three colourmaps, intended for displaying the
% red green and blue components separately.
redmap = [column_ramp,zeros(256,1),zeros(256,1)];
greenmap = [zeros(256,1),column_ramp,zeros(256,1)];
bluemap = [zeros(256,1),zeros(256,1),column_ramp];
% Below, display the three image planes in 3 separate windows
figure(1); colormap(redmap);image(X(:,:,1)); colorbar;
figure(2); colormap(greenmap);image(X(:,:,2)); colorbar;
figure(3); colormap(bluemap);image(X(:,:,3)); colorbar

figure(4);
image(X);colorbar;






