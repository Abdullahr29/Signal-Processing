close all

%% Part 1 - Looking at how the error in reconstruction changes with the 
% fraction of coefficients in transform space that we preserve.
% Head
fid = fopen('head.128','r');
[x,npels] = fread(fid,[128,128],'uchar');
x = x';
fclose(fid);

hf1=figure(1);
set(hf1,'Position',[500,500,900,300]); % This is set to give reasonable appearance of
                                       % figure window without stupid
                                       % squashing! Not really necessary...
                                       
set(hf1,'Color','w'); % gets rid of ugly grey b/g of figure window

subplot(1,3,1);imagesc(x);colormap(gray(128));

Fx = fft2(x);

whos Fx  % Note the size and nature of the Fx
%%%%

%%%%
% Inverse fft
xdash = ifft2(Fx); % 

whos xdash % Note that on different versions of Matlab, result will have a different type
           % The result *should* be real, floating point; on pre 2011
           % versions of Matlab, the result will be complex, but with a
           % very tiny (1e-15 or so!) imaginary part
          
subplot(1,3,2);imagesc(xdash)% OR imagesc(real(xdash));

%  Computing difference image
d = x - xdash; % Or x - real(xdash) for pre-2011 versions of Matlab

subplot(1,3,3);
imagesc(d);  % Looks strange, but examine the values - should be VERY small, if not zero

%% Part 2
% To visualise basis images (for example), we create an EMPTY transform
% space.....
% --------(START)--------
B = zeros(16,16);

% ...then set ANY ONE coefficient to 1; 
B(5,10) = 1;

basisimage = ifft2(fftshift(B)); % IFFT shift is only really used becaue I 
                     % like to have low rates of oscillation in the middle
                     % of 2D DFT space - also, it is sort of conventional
                     % Will also work *without* ifftshift, but the result
                     % will be a different basis image
hf2=figure(2);
set(hf2,'Position',[400,400,600,300]); % This is set to give reasonable appearance of
                                       % figure window without stupid
                                       % squashing! Not really necessary...
set(hf2,'Color','w'); % gets rid of ugly grey b/g of figure window
                                       
subplot(1,2,1);imagesc(real(basisimage));colormap(gray);title('Basis image: Real part');
subplot(1,2,2);imagesc(imag(basisimage));colormap(gray);title('Basis image: Imag Part');
%----------- (END) -----------
% Please repeat this, changing the value of B that is set to 1, and check
% the corresponding basis image. Do this carefully, to amke sure you
% understand. Then, compare with the exercise in Chapter 3 in which you are
% asked to work out what the basis images are. Make sure all makes sense.

%% Now for the Energy Compaction Stuff
% Remember that from Part 1, Fx is our Fourier domain
% representation.  First, we need to understand how the "sort" command
% works, so we can use it properly. Let's try the sort command on a bunch of 
% values in a matrix (using the help command as well !)
[v,idx] = sort([ 2 4 1; 3 1 6; 1 9 2]) % Random-ish values in
% matrix - just a small matrix to be able to see what is happening when
% we apply the sort command to it.
% 
% Look at the result of applying sport to the matrix; you should see that
% the result is actually surprising, because:
%       THIS IS SORTING THE ARRAY COLUMN BY COLUMN. 
%
% Instead, we want to sort the magnitude of the values across all of
% transform space. Instead, try this: 
M = [ 2 4 1; 3 1 6; 1 9 2] % Assign to an array;

[v,idx] = sort(M(:))

% So now the values are sorted in increasing order; let's see what else
% we can do with the "sort" command:

[v,idx] = sort(M(:),'descend') % Values are sorted in decreasing order


% Now, we can simply loop over the values 100 at a time
% Moving to the real Fourier space of the head image, and sort
% the values according to the magnitude of the transform coefficients
% (because they are complex valued; same holds for if they were to
% take positive and negative real-values only: we assume that large
% *magnitude* values contribute more than small magnitude values.

% So, let's take the image "x" into the transfor domain and sort the values
% from largest to smallest magnitude....
Fx = fft2(x); % from imagetomain into transform domain

% Sort the values, anod note what goes where (the idx variable captures
% this; to understand what this does, use the "help" command, and try
% it out on a small array of 9 values, as we did earlier to make sure 
% you appreciate what is going on
[v,idx] = sort(abs(Fx(:)),'descend');


% We will start from an empty transfgorm matrix and copy things from the
% actual transform space into this new, empty transform matrix in "chunks".
%  I set the "chunk" size to 200, here; Using a smaller number of chunks
% means that you will see the evolution of quality increase more slowly.
ChunkSize = 200;

sFx = zeros(size(Fx));
Nits = floor(length(Fx(:))/ChunkSize); % Number of iterations

hf3=figure(3);
set(hf3,'Position',[600,600,600,300]); % This is set to give reasonable appearance of
                                       % figure window without stupid
                                       % squashing! Not really necessary...
set(hf3,'Color','w'); % gets rid of ugly grey b/g of figure window
subplot(1,2,1);imagesc(x);colormap(gray);axis off

FractionofCoeffs = zeros(1,Nits); % Make an empty array to hold frac of coeffs 
for i = 1:Nits
    sFx(idx((i-1)*ChunkSize+1:i*ChunkSize)) = Fx(idx((i-1)*ChunkSize+1:i*ChunkSize));
    ydash = ifft2(sFx);
    figure(hf3); % Set focus back to Figure 3, in case user has interacted in some way
    subplot(1,2,2);imagesc(real(ydash));colormap(gray);axis off
    FractionofCoeffs(i) = i*ChunkSize/length(Fx(:)); % Inefficient - should get length() once!
    title([num2str(FractionofCoeffs(i)),' of coefficients.']);
    pause(0.15); % For better perception....
    d = double(x) - real(ydash);
    d2=d/mean(x(:));
    err(i) = sqrt(mean(d2(:).^2));
end

hf4=figure(4);
set(hf4,'Color','w');
plot(FractionofCoeffs,err,'LineWidth',3);
xlabel('Fraction of coeffs');
ylabel('Fractional error (RMS) (Crude)');
set(gca,'FontSize',16);


%% Haar Transform Part 1

% So, below, you will find that I have used the inbuilt functions in 
% a very specific way....and I do so so you can see how to get the 
% 1-D basis functions of the Haar transform (please check notes to see how
% you go from 1D to 2D - it is there, but you need to read carefully)!
% 
mpdict = wmpdictionary(4,'lstcpt',{{'haar',2}});  % "2" means 2 levels of wavelet are produced

whos mpdict % this whould show you that the dictionary of basis
            % functions does amount to 4 vectors, each of length 4
            
% To visualise, use the stem function; note that the
% matrix mpdict is sparse (compare with notes, where we place the basis
% functions of the Haar wavelet for a 1x4 basis vector into a matrix, one row 
% at a time).

[M,N] = size(mpdict);
hf1=figure(1);
set(hf1,'Color','w'); % Prettify
set(hf1,'Position',[100,100,900,300]); % Sensible reproportioning of axis

for n = 1:N
    subplot(1,N,n); stem(mpdict(:,n));axis('tight')
end

annotation('textbox', [0 0.9 1 0.1], ...
    'String', '4-point signal, 2 levels of Haar', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center',...
    'FontSize',16);
% A) There is one final difference between these coefficients and those of the
% lecture notes: what is it ?
%
% B) Note that one can explicitly "see" the multiple scales of one
% so called wavelet, which contains opposite signs of value of the form
% [+ve, -ve].  The two scales that one sees are (e.g.) [+1 -1] and 
% [+1 +1 -1 -1].  These basis functions produce large values near to edges
% of fine and "fat" scales respectively.

% Now, let's do another size of signal
mpdict = wmpdictionary(8,'lstcpt',{{'haar',2}});  % 2 means 2 levels of wavelet are produced

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hf2 = figure(2);
set(hf2,'Color','w'); % Prettify
set(hf2,'Position',[200,200,1600,200]); % Sensible reproportioning of axis

[M,N] = size(mpdict);

for n = 1:N
    subplot(1,N,n); stem(mpdict(:,n));axis('tight')
end
annotation('textbox', [0 0.9 1 0.1], ...
    'String', '8-point signal, 2 levels of Haar', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center',...
    'FontSize',16);



% And let's now compare this with another levvel of 1D wavelet
% decomposition:
mpdict = wmpdictionary(8,'lstcpt',{{'haar',3}});  % 2 means 3 levels of wavelet are produced

hf3 = figure(3);
set(hf3,'Color','w'); % Prettify
set(hf3,'Position',[400,400,1600,200]); % Sensible reproportioning of axis


for n = 1:N
    subplot(1,N,n); stem(mpdict(:,n));axis('tight')
end
annotation('textbox', [0 0.9 1 0.1], ...
    'String', '8-point signal, 3 levels of Haar', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center',...
    'FontSize',16);

% Now, check your answer to A), having done this last exercise. Can you 
% see how you would use the wmpdictionary command to "get at"
% the basis signals in a way that agrees with the 1D Haar of the lecture
% notes?  And now, what about getting to the 2D basis images (check notes!)
% Note - you SHOULD be able to do this directly from the dwt2/idwt2
% commands, as you can for the DFT practical, but the Mathwords team have
% basically "broken" the dwt2/idwt2 command, so it only generates part of
% transform space (it is described as "one level" (see Matlab
% documentation), and this is pretty much worse than useless from the
% point of either usability or understanding.


%% Haar Transform Part 2

% make the image
Im=zeros(32);
[X,Y]=meshgrid([1:32],[1:32]);
B=((X-16.5).^2+(Y-16.5).^2<10^2);
Im=Im+double(B);
figure;imagesc(Im);colormap gray; axis equal;
% this is forward 2D haar transform
% H, V, D, are the transform coefficients, 
% H - filter in horizontal direction
% V - filter in vertical direction
% D - filter in diagonal direction
[A,H,V,D]=haart2(Im);

% to visualize these H,V,D details
H %shows what is in H
figure;imagesc(H{1});colormap gray; axis equal % this is an edge detector, 1 low pass, then high pass
figure;imagesc(H{2});colormap gray; axis equal % this is 2 low pass filters before the high pass
figure;imagesc(H{3});colormap gray; axis equal % this is 3 low pass filters before the high pass
figure;imagesc(V{1});colormap gray; axis equal % this is equivalent to H1, but in the vertical direction
figure;imagesc(D{1});colormap gray; axis equal % this is equivalent to H1, but in the diagonal direction

%to inverse transform, use ihaart2
Im2=ihaart2(A,H,V,D);
figure;imagesc(Im2)

%to get basis functions, you just need to insert single entries into H, V,
%D, and do the inverse 

%% compression with Haar
%let's try a lossy compression with Haar on the head image

fid = fopen('head.128','r');
[x,npels] = fread(fid,[128,128],'uchar');
x = x';
fclose(fid);

figure;
%do a 1 level Haar
[A,H,V,D]=haart2(x,1);
%let's visualize the transform
subplot(2,2,1); imagesc(x);colormap gray; axis equal; title('original image')
subplot(2,2,2); imagesc([A,H;V,D]); colormap gray; axis equal; title('transformed 1st level')

%let's do a lossy compression, setting all low value pixels to zero in
%the transformed image
A2=(abs(A)>2).*A; %this sets all pixels less than 2 to be 0
H2=(abs(H)<2).*H;
V2=(abs(V)<2).*V;
D2=(abs(D)<2).*D;
%visualize it
subplot(2,2,3); imagesc([A2,H2;V2,D2]);colormap gray; axis equal; title('removed low values / lossy compressed')
%this image has many many more zeros, and theoretically, these zeros can be thrown away
%for compression - do not need to store them.

%inverse transform
x2=ihaart2(A2,H2,V2,D2);
subplot(2,2,4); imagesc(x2);colormap gray; axis equal; title('lossy compressed inversed transformed')



