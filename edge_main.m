clear all 
load mri
test_image = D(:,:,:,1);
edged = detect_edges(test_image);
figure(1)
subplot(1,2,1)
imagesc(test_image)
title('Original image')
axis square

subplot(1,2,2)
imagesc(edged)
title('Edge image')
axis square

colormap gray