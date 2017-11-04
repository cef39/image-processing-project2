function w = gaussKernel(m, sigma)

w = ones(m);

for x = 1:m
   for y = 1:m
      w(x,y) = exp(-(x.^2 + y.^2)/(2*sigma.^2));
   end
end