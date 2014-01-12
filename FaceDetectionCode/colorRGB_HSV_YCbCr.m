function [final_image,counter_skin] = colorRGB_HSV_YCbCr(img)

counter_skin = 0;

RGB = getRGB(img);
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
            
            R = RGB(i,j,1);
            G = RGB(i,j,2);
            B = RGB(i,j,3);
            V = [R,G,B];
            
            %             if(((R > 50  && G > 40  && B > 20 && (max(V) - min(V) > 10 ) && (abs(R-G) >= 10) && R>G && R>B) || ((R>220) && (G>210) && (B>170) && (abs(R-G)<=15) && (R>B) && (G>B))) && ( ((h > 0 && h < 35) || (h > 325 && h < 360))&&(s > 0.2 && s < 0.6)&&(v>=20) ) && ((cb >= 60 && cb <= 130) && (cr >= 130 && cr <= 165) && (y>=85) ) )
            if((0.79 * G - 67 < B && 0.78 * G + 42 > B) && ( ((h > 0 && h < 35) || (h > 325 && h < 360))&&(s > 0.2 && s < 0.6)&&(v>=20) ) && ((cb >= 60 && cb <= 130) && (cr >= 130 && cr <= 165) && (y>=85) ) )
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
