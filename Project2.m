%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 2.1

open gaussKernel.m

w = gaussKernel(60, 25);

testPattern = double(imread('testpattern.tif'));
imshow(uint8(testPattern))
title('original test pattern image')
pause

blur = filter2(w, testPattern);


blurm = blur - min(min(blur));
% scale image
blurs = 255*(blurm./max(max(blurm)));

%imshow(uint8(blur))
%pause
imshow(uint8(blurs))
title('test pattern blurred using Gaussian lowpass filter')
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

laplaceKernel = [0 -1 0; -1 4 -1; 0 -1 0];

laplaceFilteredImage = filter2(laplaceKernel, blurrymoon);

laplaceSharpened = blurrymoon + uint8(laplaceFilteredImage);

imshow(laplaceSharpened)
title('laplace sharpeneing of blurry moon')
pause

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2.3

open lpfilterTF.m

H = lpfilterTF('ideal', 512, 512, 96);
imshow(H);
title('ideal lowpass filter')
pause;

H = lpfilterTF('gaussian', 512, 512, 96);
imshow(H);
title('gaussian lowpass filter')
pause;

H = lpfilterTF('butterworth', 512, 512, [96, 2]);
imshow(H);
title('butterworth lowpass filter')
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 2.4

open hpfilterTF.m

H = hpfilterTF('ideal', 512, 512, 96);
imshow(H);
title('ideal highpass filter')
pause;

H = hpfilterTF('gaussian', 512, 512, 96);
imshow(H);
title('gaussian highpass filter')
pause;

H = hpfilterTF('butterworth', 512, 512, [96, 2]);
imshow(H);
title('butterworth highpass filter')
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 2.5

%% part a and b

%% filtering blurrymoon with butterworth lowpass in frequency domain
blurryMoonSize = size(blurrymoon);

H = lpfilterTF('butterworth', blurryMoonSize(1, 1) .* 2, blurryMoonSize(1, 2) .* 2, [32, 2]);

g = fdfiltering(blurrymoon, H);

imshow(uint8(g))
title('blurrymoon.tif - filtering in frequency domain with butterworth lowpass')
pause

%% filtering testpattern with butterworth lowpass in frequency domain
testPatternSize = size(testPattern);

H = lpfilterTF('butterworth', testPatternSize(1, 1) .* 2, testPatternSize(1, 2) .* 2, [32, 2]);

g = fdfiltering(testPattern, H);

imshow(uint8(g))
title('testpattern.tif - filtering in frequency domain with butterworth lowpass')
pause

%% part c

%% filtering blurrymoon with butterworth highpass in frequency domain
blurryMoonSize = size(blurrymoon);

H = hpfilterTF('butterworth', blurryMoonSize(1, 1) .* 2, blurryMoonSize(1, 2) .* 2, [16, 2]);

g = fdfiltering(blurrymoon, H);

imshow(uint8(g))
title('blurrymoon.tif - filtering in frequency domain with butterworth highpass')
pause

%% filtering testpattern with butterworth highpass in frequency domain
testPatternSize = size(testPattern);

H = hpfilterTF('butterworth', testPatternSize(1, 1) .* 2, testPatternSize(1, 2) .* 2, [32, 2]);

g = fdfiltering(testPattern, H);

imshow(uint8(g))
title('testpattern.tif - filtering in frequency domain with butterworth highpass')
pause
