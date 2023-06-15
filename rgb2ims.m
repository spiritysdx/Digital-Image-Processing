function [L,M,S]=rgb2ims(rgb)

r=rgb(:,:,1);
g=rgb(:,:,2);
b=rgb(:,:,3);
l = 0.3811*r + 0.5783*g + 0.0402*b;
m = 0.1967*r + 0.7244*g + 0.0782*b;
s = 0.0241*r + 0.1288*g + 0.8444*b;
L=log(double(l)./255);
M=log(double(m)./255);
S=log(double(s)./255);
end