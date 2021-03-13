%% task 2

clear all; close all; clc;
fid = fopen('head.128','r');
[x,npels] = fread(fid,[128,128],'uchar');
x = x';
fclose(fid); % Close the file handle 
figure;image(x);
mymap = colormap(gray(256));
colorbar
x = double(x);
y = fft2(x);
z = fftshift(y);

figure;imagesc(log(abs(z)));

xdash = ifft2(y);

figure;imagesc(xdash);
mymap = colormap(gray(256));
colorbar

per = immse(x, xdash);

fprintf('\n The mean-squared error is %0.4f\n', per);

% diff = x - xdash;
% 
% diffsum = sum(diff.^2, 'all');

%% task 2.1

m = zeros(16);
m(5, 10) = 1;

mdash = ifft2(m);
imagPart = imag(mdash(:,:));
realPart = real(mdash(:,:));

figure;imagesc(m);colormap(gray(256));colorbar;
figure;imagesc(imagPart);colormap(gray(256));colorbar;
figure;imagesc(realPart);colormap(gray(256));colorbar;

m(5, 10) = 0;

m(8, 10) = 1;

mdash2 = ifft2(m);
imagPart2 = imag(mdash2(:,:));
realPart2 = real(mdash2(:,:));

figure;imagesc(m);colormap(gray(256));colorbar;
figure;imagesc(imagPart2);colormap(gray(256));colorbar;
figure;imagesc(realPart2);colormap(gray(256));colorbar;

basis = mdash.*(mdash2);
basis = abs(basis(:,:));

figure;imagesc(basis);colormap(gray(256));colorbar;


%% task 2.2
tempy = reshape(y,1,[]);
[tempj, I] = sort(tempy,'descend','ComparisonMethod','abs');
mats = zeros(128);
figure;
for j = 1:160
    lim1 = (j-1)*100;
    lim2 = j*100;
    if(lim1 == 0)
        lim1 = 1;
    end
    for i = lim1:lim2
        n = I(i);
        d = 128;
        r = rem(n,d);
        q = (n-r)/d;
        q = q+1;
        if(r == 0)
            r = 128;
            q = q-1;
        end
        mats(q,r) = tempj(i);
    end
    fdash = ifft2(mats);
    fdash=fdash.';
    imagesc(abs(fdash));colormap(gray(256));
    pause(0.2);
    errors(j) = immse(x, abs(fdash));
end
figure;
plot(errors);

%% task 3

[mpdict,~,~,longs] = wmpdictionary(8,'lstcpt',{{'haar',2}});

[X,Y] = meshgrid(1:128,1:128);

figure;
F = sqrt((X-64).^2 + (Y-64).^2);
Fbin = (F < 20);
imagesc(F);
figure;
imagesc(Fbin);colormap(gray(256));
[L, H, V, D] = haart2(double(Fbin),2);
figure;imagesc(L);
        
        
%use mpdict to visualise bases

