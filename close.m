%Examples: Morphologically close image

originalBW = imread('circles.png');
se = strel('disk',10);
closeBW = imclose(originalBW,se);
figure;
subplot(1,2,1),imshow(originalBW);
subplot(1,2,2),imshow(closeBW);
