function g = fdfiltering(f, H)

% creating padded image of size 2Px2Q
fsize = size(f);
P = fsize(1,1) * 2;
Q = fsize(1,2) * 2;

fpadded = zeros(P, Q);

fpadded(1:fsize(1,1), 1:fsize(1,2)) = f;

%multiply by (-1)^(x + y) to center transform
for x = 1:P
    for y = 1:Q
        fpadded(x, y) = fpadded(x, y) .* ((-1).^(x + y));
    end
end

% computer dft of image
F = fft2(fpadded);

% multiply g by H now
G = F .* H;

% find inverse DFT of image and obtain real part
gpadded = real(ifft2(G));

%multiply by (-1)^(x + y) to obtain processed image
for x = 1:P
    for y = 1:Q
        gpadded(x, y) = gpadded(x, y) .* ((-1).^(x + y));
    end
end

% return the first MxN section to get unpadded filtered image
g = gpadded(1:fsize(1,1), 1:fsize(1,2));


