%% Task 1

close all; clear all;
IM = imread('croppedpeasondesk.jpg');
imagesc(IM)
Xgray = rgb2gray(IM);
imagesc(Xgray); colormap gray
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
hist(double(Xgray(:)),50)
% Note lack of clear separation of components
imagesc(Xgray>130)

X = double(IM);

% the following computes the trchromatic coefficients
rc = X(:,:,1)./sum(X,3); % sum over r,g,b components in denominator
gc = X(:,:,2)./sum(X,3);
bc = X(:,:,3)./sum(X,3);

figure(1);colormap(gray(256));
subplot(1,3,1); imagesc(rc); title('Red TC')
subplot(1,3,2); imagesc(gc);title('Green TC')
subplot(1,3,3); imagesc(bc);title('Blue TC')

% let us look at the histograms of the blue and green components
figure(2);
subplot(1,2,1);hist(gc(:),100);title('Green TC Histogram')
subplot(1,2,2);hist(bc(:),100);title('Blue TC Histogram')

% The Blue histogram is  the better one, offering a clear valley
% between the peaks of the distribution.
bbc = (bc<0.3);
figure;
subplot(1,2,1);
imagesc(bbc);


%% Task 2
% Now, let's label each region, and get region properties
bbclabeled = bwlabel(bbc);

Regions = regionprops(bbclabeled);

Areas =[];
for i = 1:length(Regions)
    Areas = [Areas,Regions(i).Area];   % Put all areas into one to have a look
end;

% Hint: You will have lots of peas on their own, but also lots of peas
% stuck together in clumps.   Try setting a range of expected pea sizes,
% and keeping only the regions you think are single peas.
% In a later practical, we will consider how to remove peas that are "stuck
% together"
PeaRegions = [];
for i = 1:length(Regions)
    if (Regions(i).Area > 500) & (Regions(i).Area < 1200)
        PeaRegions = [PeaRegions, Regions(i)];        
    end
end;

subplot(1,2,2);
imagesc(IM);
for i = 1:length(PeaRegions);
    h=rectangle('Position',PeaRegions(i).BoundingBox);
    set(h,'EdgeColor','r');
end;
% Vary the parameters (700 and 1000) until you get the best
% performance possible. How do you judge the  performance ?

%% Task 3

% To Compute the "mean pea" across "p-space"...(do try not to laugh)
% we need all bondinb boxes to be the same, otherwise we cannot average
% across "p-space"
% First, find the BB which is largest, 
for i = 1:length(PeaRegions)
    BB(i,:) = PeaRegions(i).BoundingBox;
end
BigBB = max(BB);  % Check BB and BigBB to seee what the relation is
BigBBWH = BigBB(3:4);  % The first two value in BigBB are nonsense
                                % This gets width and height

% Now, in order to address with centroid and BB, we need to 
% extract regions from matrix X centred at the centroids, of widths &
% heights given by BigBB

numPeasNotOnBoundary = 0;
for i = 1:length(PeaRegions)
    UpperLeftRowNum = floor(PeaRegions(i).Centroid(2) - BigBBWH(2)/2);
    UpperLeftColNum = floor(PeaRegions(i).Centroid(1) - BigBBWH(1)/2);
    LowerRightRowNum = UpperLeftRowNum+BigBBWH(2);
    LowerRightColNum = UpperLeftColNum+BigBBWH(1);
    if (UpperLeftRowNum > 0 & UpperLeftColNum > 0) & (LowerRightRowNum<=size(IM,1) & LowerRightColNum<=size(IM,2))
        numPeasNotOnBoundary = numPeasNotOnBoundary+1;
        PeaStack(:,:,:,numPeasNotOnBoundary) = IM(UpperLeftRowNum:LowerRightRowNum,UpperLeftColNum:LowerRightColNum,1:3);
    end
end

size(PeaStack)

figure;
subplot(1,2,1);
montage(PeaStack);title('Pea Database');
MeanPeaTrueColour=mean(PeaStack,4);
MeanPeaTrueColour = MeanPeaTrueColour/max(MeanPeaTrueColour(:));
subplot(1,2,2);
imagesc(MeanPeaTrueColour); axis equal
title('Mean Pea');

% Now, tell me that isn't cool.....