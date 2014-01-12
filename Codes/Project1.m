%%%%% Clear All %%%%%
close all;
clear all;
clc;

%%%%% Load Image %%%%%
 rgbInputImage = imread('./Images/images4.jpg');

% figure,imshow(rgbInputImage);
% size(rgbInputImage,1)
% size(rgbInputImage,2)
% axis([0 size(rgbInputImage,1) 0 size(rgbInputImage,2)]);
% 
% T = rgbInputImage(35:150,50:140);
% T = imresize(T,[30 30]);
% % T = imcrop(T);
% figure,imshow(T);
% imwrite(T,'./Images/template.jpg');

%%%%% Increase Brightness %%%%%
% figure,imshow(rgbInputImage);
img = increaseBrightness(rgbInputImage);
% figure,imshow(img);

% img = rgbInputImage;
% figure,imshow(img);

%%%%% Algorithm used %%%%%%
[final_image,counter_skin] = colorRGB_HSV_YCbCr(img);

counter_total = size(img,1) * size(img,2);
% counter_perim = 20 * counter_skin / counter_total;
counter_perim = 1;
valid_size = 500;

%%%%% Grayscale To Binary %%%%%%
binaryImage=im2bw(final_image,0.1);                   %%%%%% converting image into binary image

% %%%%% Filling The Holes %%%%%%

% se = strel(ones(3,3));
% 
% binaryImage1 = imfill(binaryImage,'holes');
% figure, imshow(binaryImage1);
% 
% se = strel('disk',10);
% binaryImage1 = imerode(binaryImage1, se);
% figure, imshow(binaryImage1);
% 
% se1 = strel('disk',8); 
% binaryImage1 = imdilate(binaryImage1,se1);
% figure, imshow(binaryImage1);
% 
% binaryImage = immultiply(binaryImage1,binaryImage);
% figure, imshow(binaryImage);

figure, imshow(binaryImage);
binaryImage = imfill(binaryImage,'holes');            %%%%%% fill the holes in an area
figure, imshow(binaryImage);


for k=1:counter_perim                                 %%%%%% show only perimeter pixels
    binaryImage1 = bwperim(binaryImage,8);            %%%%%% remove perimeter pixels from binary image
    binaryImage = binaryImage - binaryImage1;
    figure,imshow(binaryImage);
end

%%%%%% Putting Boxes %%%%%%
binaryImage = bwareaopen(binaryImage,valid_size);    %%%%%% remove small areas of fewer than a value

% figure,imshow(binaryImage);
labeledImage = bwlabel(binaryImage, 8);              %%%%%% label different objects in the image 
blobMeasurements = regionprops(labeledImage, final_image, 'all');
numberOfPeople = size(blobMeasurements, 1);

% [boundaries,considerPeople] = getBoundaries(rgbInputImage,numberOfPeople,binaryImage);

imagesc(rgbInputImage);                              %%%%%% scale image according to size in pixels
hold on;
title('Original with bounding boxes.');
for k = 1 : numberOfPeople
    thisBlobsBox = blobMeasurements(k).BoundingBox;
    ecen = blobMeasurements(k).Eccentricity;
    
%     maj = blobMeasurements(k).MajorAxisLength;
%     min = blobMeasurements(k).MinorAxisLength;
       
    x1 = thisBlobsBox(1);
    y1 = thisBlobsBox(2);
    x2 = x1 + thisBlobsBox(3);
    y2 = y1 + thisBlobsBox(4);
 
    a = thisBlobsBox(3) / thisBlobsBox(4);
    
    x = [x1 x2 x2 x1 x1];
    y = [y1 y1 y2 y2 y1];
    
    ecen
    a
    
    if((ecen > 0.25) && (ecen < 0.97) && (a < 1.2) &&( a > 0.4) )
        plot(x, y, 'LineWidth', 2);
    end
end