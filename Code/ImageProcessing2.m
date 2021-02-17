%% Intro
clear all; close all; clc;

[X,map] = imread('croppedpeasondesk.jpg');

whos map

whos X

figure;
image(X);colorbar;

%% Task 1
figure;
G = rgb2gray(X);

imagesc(G); colormap(gray(256)); % imagesc is like image , but scales the values in X to
                                 %the range of the colourmap; 
                                 
G = double(G); % hist needs a double type to work
g = G(:); % G(:) converts the 2D matrix into a 1D array; also could use reshape command
figure;
histogram(g,50); % Note the number of bins, which is 10;
figure;
histogram(g,100); % Note the histogram now; what is the difference

T = 130;%best value of T to perserve as much data as possible

gbin = (G > T);
figure;
imagesc(gbin);

figure;
subplot(1,3,1);image(X(:,:,1));axis square; axis off
subplot(1,3,2);image(X(:,:,2));axis square; axis off
subplot(1,3,3);image(X(:,:,3));axis square; axis off
colormap(gray(256));



column_ramp = [0:1/255:1]';
redmap = [column_ramp,zeros(256,1),zeros(256,1)];
greenmap = [zeros(256,1),column_ramp,zeros(256,1)];
bluemap = [zeros(256,1),zeros(256,1),column_ramp];
% Below, display the three image planes in 3 separate windows
figure;colormap(redmap);imagesc(X(:,:,1)); colorbar;
figure; colormap(greenmap);imagesc(X(:,:,2)); colorbar;
figure; colormap(bluemap);imagesc(X(:,:,3)); colorbar;

R = X(:,:,1);G = X(:,:,2); B = X(:,:,3);

D = double(R) + double(G) + double(B); 

x = double(R)./D; % NOT just a / or you will get nonsense!

y = double(G)./D;

z = double(B)./D;

BIGGEST = max([x(:);y(:);z(:)]);% read carefully!
SMALLEST = min([x(:);y(:);z(:)]);

isx = 1+round(255*(x - SMALLEST)/(BIGGEST - SMALLEST));
isy = 1+round(255*(y - SMALLEST)/(BIGGEST - SMALLEST));
isz = 1+round(255*(z - SMALLEST)/(BIGGEST - SMALLEST));

figure;
subplot(1,3,1);image(isx);axis square; axis off
subplot(1,3,2);image(isy);axis square; axis off
subplot(1,3,3);image(isz);axis square; axis off
colormap(gray(256));

gr = isz;
gr = double(gr);
gra = gr(:);
figure;
histogram(gra,100);

T = 90;%best value of T to perserve as much data as possible
Lt = 150;

gbin = (gr < T);
%gbin = (gr > Lt) & (gr < T);
figure;
imagesc(gbin);colormap(gray(256));

%% Task 2
figure;
[lbl, n] = bwlabel(gbin, 4);

imagesc(lbl);
hold on
s = regionprops(lbl);
centroids = cat(1,s.Centroid);
areas = cat(1,s.Area);
a = areas(:,1);
bbs = cat(1, s.BoundingBox);
mn = mean(a);
st = std(a);
vec = [bbs(:,1) bbs(:,2) bbs(:,3) bbs(:,4)];
x = [];
for i = 1:size(vec,1)
    if((vec(i,3) > 15) && (vec(i,4) > 10) && (vec(i,4) < 200) && (vec(i,3) < 200))
        r=rectangle('Position', [vec(i,1) vec(i,2) vec(i,3) vec(i,4)]);
        set(r,'EdgeColor','g');
        r=text(vec(i,1), vec(i,2), num2str(i));
        plot(centroids(i,1),centroids(i,2),'b*')
        x = [x, i];
    end
end
%plot(centroids(:,1),centroids(:,2),'b*')
hold off

figure;
edg = [0:1:1800];
histogram(a, edg);

%% Task 3
%x has indices of peas or pea groups


