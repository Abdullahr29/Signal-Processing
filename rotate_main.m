clear all 
load mri
test_image = D(:,:,:,1);
rotated_image = rotate_image(test_image, pi/4);
figure(1)
subplot(1,2,1)
imagesc(test_image)
title('Original image')
axis square

subplot(1,2,2)
imagesc(rotated_image)
title('Rotated image')
axis square

colormap gray