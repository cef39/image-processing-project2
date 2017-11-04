%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 2.1

open gaussKernel.m

w = gaussKernel(12, 2)

testPattern = imread('testpattern.tif');
imshow(testPattern)
pause

blur = filter2(w, testPattern);
imshow(blur)
pause


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 2.2

%% Part a


blurrymoon = imread('blurrymoon.tif');

%% Gaussian blurring kernel
kernel = fspecial('Gaussian', 32, 8);

%% apply blurring kernel to image to get blurred image
blurredImage = imfilter(blurrymoon, kernel, 'replicate');

%% create unsharp mask by subtracting smoothed image from original image
unsharpMask = blurrymoon - blurredImage;

%% perform unsharp masking by adding unsharp mask to original image
sharpedImage = blurrymoon + unsharpMask;

imshow(blurrymoon)
title('image of blurry moon')
pause

% imshow(unsharpMask)
% title('unsharp mask of blurrymoon')
% pause

imshow(sharpedImage)
title('sharpened image of blurry moon')
pause


%% Part b

highboost = blurrymoon + 2*unsharpMask;

imshow(highboost)
title('highboost filtering of blurry moon')
pause

%% Part c

