% Created on 09/01/25
% Author: Himanshu Joshi, BT22ECE108
% Practical 1: Conversion of a Color Image to Grayscale and Color Tinting.

clc
clear all
close all

% Load the input color image
I = imread("ref_img.jpg");

% Display the pixel intensity at a specific location (row 200, column 350)
disp(['Pixel Intensity at (200, 350): ', num2str(I(200,350))]);

% Convert to Grayscale using the Red channel only
I_gr1 = I(:,:,1);

% Convert to Grayscale using the average of Red, Green, and Blue channels
I_red = I(:,:,1); % Extract Red channel
I_green = I(:,:,2); % Extract Green channel
I_blue = I(:,:,3); % Extract Blue channel
I_gr2 = round((I_red + I_green + I_blue) / 3);

% Convert to Grayscale using the luminosity formula for better accuracy
I_gr3 = round(0.299 * I_red + 0.587 * I_green + 0.114 * I_blue);

% Generate the Red-tinted version of the image (suppress Green and Blue)
Ired = I;
Ired(:,:,2) = 0; % Remove Green component
Ired(:,:,3) = 0; % Remove Blue component

% Generate the Green-tinted version of the image (suppress Red and Blue)
Igreen = I;
Igreen(:,:,1) = 0; % Remove Red component
Igreen(:,:,3) = 0; % Remove Blue component

% Generate the Blue-tinted version of the image (suppress Red and Green)
Iblue = I;
Iblue(:,:,1) = 0; % Remove Red component
Iblue(:,:,2) = 0; % Remove Green component

% Display the original image and different grayscale conversions
figure(1)
subplot(2,2,1), imshow(I); xlabel("Original Color Image");
subplot(2,2,2), imshow(I_gr1); xlabel("Grayscale (Using Red Channel)");
subplot(2,2,3), imshow(I_gr2); xlabel("Grayscale (Average of Channels)");
subplot(2,2,4), imshow(I_gr3); xlabel("Grayscale (Using Luminosity)");

% Display the original image and color-tinted versions
figure(2)
subplot(2,2,1), imshow(I); xlabel("Original Color Image");
subplot(2,2,2), imshow(Ired); xlabel("Red-Tinted Image");
subplot(2,2,3), imshow(Igreen); xlabel("Green-Tinted Image");
subplot(2,2,4), imshow(Iblue); xlabel("Blue-Tinted Image");
