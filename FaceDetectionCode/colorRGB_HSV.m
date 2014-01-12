function [final_image,counter_skin] = colorRGB_HSV(img)

counter_skin = 0;

RGB = getRGB(img);
HSV = getHSV(img);

final_image = zeros(size(img,1), size(img,2));

for i = 1:size(img,1)
    for j = 1:size(img,2)
        
        R = RGB(i,j,1);
        G = RGB(i,j,2);
        B = RGB(i,j,3);
        V = [R,G,B];
        
        h = HSV(i,j,1);
        s = HSV(i,j,2);
        v = HSV(i,j,3);
        
        if(((R > 50  && G > 40  && B > 20 && (max(V) - min(V) > 10 ) && (abs(R-G) >= 10) && R>G && R>B) || ((R>220) && (G>210) && (B>170) && (abs(R-G)<=15) && (R>B) && (G>B))) && ( ((h > 0 && h < 35) || (h > 325 && h < 360))&&(s > 0.2 && s < 0.6)&&(v>=20) ) )
            final_image(i,j)=1;
            counter_skin = counter_skin + 1;
        end
        
    end
end