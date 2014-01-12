function [HSV] = getHSV(img)

HSV = zeros(size(img,1), size(img,2),3);

img = rgb2hsv(img);
H = img(:,:,1) * 360.0;
S = img(:,:,2) * 1.0;
V = img(:,:,3) * 100.0;

if(size(img, 3) > 1)
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            
            HSV(i,j,1) = H(i,j);
            HSV(i,j,2) = S(i,j);
            HSV(i,j,3) = V(i,j);
            
        end
    end
end
