function [final_image,counter_skin] = colorRGB(img)

counter_skin = 0;

final_image = zeros(size(img,1), size(img,2));

RGB = getRGB(img);

if(size(RGB, 3) > 1)
    for i = 1:size(RGB,1)
        for j = 1:size(RGB,2)
            
            R = RGB(i,j,1);
            G = RGB(i,j,2);
            B = RGB(i,j,3);
            v = [R,G,B];
            
            %             if((R > 50  && G > 40  && B > 20 && (max(v) - min(v) > 10 ) && (abs(R-G) >= 10) && R>G && R>B) ||    ((R>220) && (G>210) && (B>170) && (abs(R-G)<=15) && (R>B) && (G>B))    )
            %                 final_image(i,j)=1;
            %                 counter_skin = counter_skin + 1;
            %             end
            %
            
            if(0.79 * G - 67 < B && 0.78 * G + 42 > B)
                final_image(i,j)=1;
                counter_skin = counter_skin + 1;
                %             else
                %                 img(i,j,1) = 0;
                %                 img(i,j,2) = 0;
                %                 img(i,j,3) = 0;
            end
            
        end
    end
end

% figure,imshow(img);