clear; close all; % Close all windows, and clear all variables
[X,map] = imread('trees.tif'); 
image(X); % Display the image…
colormap(map); % with its colormap (as read from the TIFF file)
colorbar;