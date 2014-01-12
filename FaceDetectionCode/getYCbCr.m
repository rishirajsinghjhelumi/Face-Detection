function [YCbCr] = getYCbCr(img)

YCbCr = zeros(size(img,1), size(img,2),3);

YCBCR = rgb2ycbcr(img);
Y=YCBCR(:,:,1);
Cb=YCBCR(:,:,2);
Cr=YCBCR(:,:,3);


if(size(img, 3) > 1)
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            
            YCbCr(i,j,1) = Y(i,j);
            YCbCr(i,j,2) = Cb(i,j);
            YCbCr(i,j,3) = Cr(i,j);
            
        end
    end
end
