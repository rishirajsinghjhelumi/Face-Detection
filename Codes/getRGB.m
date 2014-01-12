function [RGB] = getRGB(img)

RGB = zeros(size(img,1), size(img,2),3);

if(size(img, 3) > 1)
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            
            RGB(i,j,1) = img(i,j,1);
            RGB(i,j,2) = img(i,j,2);
            RGB(i,j,3) = img(i,j,3);
            
        end
    end
end
