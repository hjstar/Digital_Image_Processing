% Created on 23/01/25
% Created by Himanshu Joshi, BT22ECE108
% Practical 3: Bit-plane Slicing on a Grayscale Image.

clc;
clear all;
close all;

% Load and convert an image to grayscale
originalImage = imread("test.png");
grayscaleImage = rgb2gray(originalImage);

% Extract individual bit planes
imageDouble = double(grayscaleImage);
bitPlane1 = mod(imageDouble, 2);
bitPlane2 = mod(floor(imageDouble / 2), 2);
bitPlane3 = mod(floor(imageDouble / 4), 2);
bitPlane4 = mod(floor(imageDouble / 8), 2);
bitPlane5 = mod(floor(imageDouble / 16), 2);
bitPlane6 = mod(floor(imageDouble / 32), 2);
bitPlane7 = mod(floor(imageDouble / 64), 2);
bitPlane8 = mod(floor(imageDouble / 128), 2);

% Create a compressed image excluding the least significant bit
compressedImage = (2^0)*bitPlane2 + (2^1)*bitPlane3 + (2^2)*bitPlane4 + ...
                  (2^3)*bitPlane5 + (2^4)*bitPlane6 + (2^5)*bitPlane7 + ...
                  (2^6)*bitPlane8; 

% Display original and compressed images
figure;
subplot(1, 2, 1), imshow(grayscaleImage), title('Original Grayscale Image');
subplot(1, 2, 2), imshow(uint8(compressedImage)), title('Compressed Image (7-bit)');

% Display bit-plane decomposition
figure;
subplot(2, 4, 1), imshow(bitPlane8), title('Bit Plane 8 (MSB)');
subplot(2, 4, 2), imshow(bitPlane7), title('Bit Plane 7');
subplot(2, 4, 3), imshow(bitPlane6), title('Bit Plane 6');
subplot(2, 4, 4), imshow(bitPlane5), title('Bit Plane 5');
subplot(2, 4, 5), imshow(bitPlane4), title('Bit Plane 4');
subplot(2, 4, 6), imshow(bitPlane3), title('Bit Plane 3');
subplot(2, 4, 7), imshow(bitPlane2), title('Bit Plane 2');
subplot(2, 4, 8), imshow(bitPlane1), title('Bit Plane 1 (LSB)');
