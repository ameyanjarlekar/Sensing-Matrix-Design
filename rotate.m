function [outputimg] = rotate(test_img,angle)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[p,q] = size(test_img);
test_img1 = zeros(3*p,3*q);
test_img1(1:p,1:q) = test_img;
test_img1(1:p,q+1:2*q) = test_img;
test_img1(1:p,2*q+1:3*q) = test_img;
test_img1(p+1:2*p,1:q) = test_img;
test_img1(p+1:2*p,q+1:2*q) = test_img;
test_img1(p+1:2*p,2*q+1:3*q) = test_img;
test_img1(2*p+1:3*p,1:q) = test_img;
test_img1(2*p+1:3*p,q+1:2*q) = test_img;
test_img1(2*p+1:3*p,2*q+1:3*q) = test_img;
test_small = imrotate(test_img1,angle,'bilinear','crop');
outputimg=test_small(p+1:2*p,q+1:2*q);
end