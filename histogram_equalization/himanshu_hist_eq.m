% Histogram Equalization Implementation
% Created on: 16/01/25
% Author: Himanshu Joshi, BT22ECE108

clc;
clear;
close all;

% Step 1: Load Image and Convert to Grayscale
input_image = imread("test.jpg");
red_channel = input_image(:,:,1);
green_channel = input_image(:,:,2);
blue_channel = input_image(:,:,3);
gray_image = uint8(0.299 * red_channel + 0.587 * green_channel + 0.114 * blue_channel);

[img_rows, img_cols] = size(gray_image);
total_pixels = img_rows * img_cols;

% Step 2: Calculate Histogram
histogram_original = zeros(1, 256);
for intensity = 0:255
    histogram_original(intensity + 1) = sum(gray_image(:) == intensity);
end

% Step 3: Compute CDF
cdf_original = cumsum(histogram_original);
min_cdf_value = min(cdf_original(cdf_original > 0));

% Step 4: Equalize the Image
equalized_image = zeros(size(gray_image));
for row = 1:img_rows
    for col = 1:img_cols
        pixel_value = gray_image(row, col);
        equalized_image(row, col) = round(((cdf_original(pixel_value + 1) - min_cdf_value) * 255) / (total_pixels - min_cdf_value));
    end
end
equalized_image = uint8(equalized_image);

% Step 5: Compute Histogram of Equalized Image
histogram_equalized = zeros(1, 256);
for intensity = 0:255
    histogram_equalized(intensity + 1) = sum(equalized_image(:) == intensity);
end

% Step 6: Compute CDF of Equalized Image
cdf_equalized = cumsum(histogram_equalized);

% Step 7: Visualization
figure;

% Display Original Grayscale Image
subplot(2, 2, 1);
imshow(gray_image);
title("Original Grayscale Image");

% Display Equalized Image
subplot(2, 2, 3);
imshow(equalized_image);
title("Equalized Image");

% Plot Histogram and CDF of Original Image
subplot(2, 2, 2);
yyaxis left;
stem(0:255, histogram_original, "MarkerSize", 2);
yyaxis right;
plot(0:255, cdf_original / total_pixels, "r-", "LineWidth", 1.2);
legend('Histogram', 'CDF', 'Location', 'northwest');
title("Original Image: Histogram & CDF");

% Plot Histogram and CDF of Equalized Image
subplot(2, 2, 4);
yyaxis left;
stem(0:255, histogram_equalized, "MarkerSize", 2);
yyaxis right;
plot(0:255, cdf_equalized / total_pixels, "r-", "LineWidth", 1.2);
legend('Histogram', 'CDF', 'Location', 'northwest');
title("Equalized Image: Histogram & CDF");
