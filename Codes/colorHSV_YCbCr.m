function [final_image,counter_skin] = colorHSV_YCbCr(img)

counter_skin = 0;

HSV = getHSV(img);
YCbCr = getYCbCr(img);

final_image = zeros(size(img,1), size(img,2));

if(size(img, 3) > 1)
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            
            h = HSV(i,j,1);
            s = HSV(i,j,2);
            v = HSV(i,j,3);
            
            y = YCbCr(i,j,1);
            cb = YCbCr(i,j,2);
            cr = YCbCr(i,j,3);
            
            if( ( (cb > 85 && cb < 140) && (cr > 140 && cr < 180) && (y >=85) ) && ( ((h > 0 && h < 35) || (h > 325 && h < 360))&&(s > 0.2 && s < 0.6)&&(v>=20) ) )
                final_image(i,j)=1;
                counter_skin = counter_skin + 1;
            
            else
                img(i,j,1) = 0;
                img(i,j,2) = 0;
                img(i,j,3) = 0;
            end
        end
    end
end
figure,imshow(img);