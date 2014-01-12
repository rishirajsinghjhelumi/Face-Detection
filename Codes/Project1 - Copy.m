     close all;
 clear all;
 clc;
 
 %%%%% Increasing Brightness %%%%%
 
%  [img,map] = imread('test01.tif');
 rgbInputImage = imread('./Images/images4.jpg');
 %rgbInputImage=getsnapshot(rgbInputImage);
 labInputImage = applycform(rgbInputImage,makecform('srgb2lab'));
 Lbpdfhe = fcnBPDFHE(labInputImage(:,:,1));
 labOutputImage = cat(3,Lbpdfhe,labInputImage(:,:,2),labInputImage(:,:,3));
 rgbOutputImage = applycform(labOutputImage,makecform('lab2srgb'));
%  figure, imshow(rgbInputImage);
 % figure, imshow(rgbOutputImage);
 img = rgbOutputImage;
 
%  img = rgb2hsv(img);
%  H = img(:,:,1);
%  S = img(:,:,2);
%  V = img(:,:,3);
%   
% %  YCBCR = rgb2ycbcr(img);
% %  Y=YCBCR(:,:,1);
% %  Cb=YCBCR(:,:,2);
% %  Cr=YCBCR(:,:,3);
% 
%  final_image = zeros(size(img,1), size(img,2));
final_image = colorHSV(img);
% 
%  
%  %%%%%% Marking the skin color %%%%%%%
%  
%  if(size(img, 3) > 1)
%     for i = 1:size(img,1)
%         for j = 1:size(img,2)
%             
%             R = img(i,j,1);
%             G = img(i,j,2);
%             B = img(i,j,3);
% 
% %             if(R > 100 && G > 40 && B > 20)
% %                 v = [R,G,B];
% %                 if((max(v) - min(v)) > 15)
% %                     if(abs(R-G) > 15 && R > G && R > B)
% %                         final_image(i,j)=1;
% %                     end
% %                 end
% %             end
%  
%             h = H(i,j) * 360.0;
%             s = S(i,j) * 1.0;
%             v = V(i,j) * 100.0;
%             
%             if((h > 0 && h < 35) || (h > 325 && h < 360))
%                 if(s > 0.2 && s < 0.6)
%                     if(v > 20)
%                         final_image(i,j) = 1;
%                     end
%                 end
%             end
% 
% %             y = Y(i,j);
% %             cb = Cb(i,j);
% %             cr = Cr(i,j);
% %          
% %             if( y > 85 )
% %                 if(cb > 85 && cb < 140)
% %                     if(cr > 140 && cr < 180)
% %                         final_image(i,j) = 1;
% %                     end
% %                 end
% %             end
% %         
%         end
%     end
%  end
%  
%   imshow(final_image);

 
%%%%%% Removing unwanted Holes in the image %%%%%%%

% Grayscale To Binary.
binaryImage=im2bw(final_image,0.6);
% figure, imshow(binaryImage);

%Filling The Holes.
binaryImage = imfill(binaryImage, 'holes');
figure, imshow(binaryImage);
  

%%%%%%Putting Boxes %%%%%%
binaryImage = bwareaopen(binaryImage,500);   
figure,imshow(binaryImage);
labeledImage = bwlabel(binaryImage, 8);
blobMeasurements = regionprops(labeledImage, final_image, 'all');
numberOfPeople = size(blobMeasurements, 1)
imagesc(rgbInputImage); 
title('Outlines, from bwboundaries()'); 
%axis square;
hold on;
boundaries = bwboundaries(binaryImage);

temp = -1;
for k = 1 : numberOfPeople
thisBoundary = boundaries{k};

minx = min(thisBoundary(:,1));
maxx = max(thisBoundary(:,1));
miny = min(thisBoundary(:,2));
maxy = max(thisBoundary(:,2));

ratio = (maxy - miny)*1.0 / (maxx - minx);
if(1.0/ratio > 1.9)
    temp = k;
end


plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
end
hold off;


imagesc(rgbInputImage);
hold on;
title('Original with bounding boxes');
%fprintf(1,'Blob # x1 x2 y1 y2\n');
for k = 1 : numberOfPeople % Loop through all blobs.
% Find the mean of each blob. (R2008a has a better way where you can pass the original image
% directly into regionprops. The way below works for all versionsincluding earlier versions.)
thisBlobsBox = blobMeasurements(k).BoundingBox; % Get list of pixels in current blob.
x1 = thisBlobsBox(1);
y1 = thisBlobsBox(2);
x2 = x1 + thisBlobsBox(3);
y2 = y1 + thisBlobsBox(4);


   % fprintf(1,'#%d %.1f %.1f %.1f %.1f\n', k, x1, x2, y1, y2);
x = [x1 x2 x2 x1 x1];
y = [y1 y1 y2 y2 y1];
%subplot(3,4,2);
if(k~=temp)
    plot(x, y, 'LineWidth', 2);
end
end

% 
% figure, imshow(labeledImage);
% B = bwboundaries(binaryImage);
% imshow(B);
% text(10,10,strcat('\color{green}Objects Found:',num2str(length(B))))
% hold on
% for k = 1:length(B)
% boundary = B{k};
% plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 0.2)
% end
% % end