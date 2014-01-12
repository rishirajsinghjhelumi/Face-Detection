function [final_image,counter_skin] = colorHSV(img)

counter_skin = 0;

HSV = getHSV(img);

final_image = zeros(size(HSV,1), size(HSV,2));

for i = 1:size(HSV,1)
    for j = 1:size(HSV,2)
        
        h = HSV(i,j,1);
        s = HSV(i,j,2);
        v = HSV(i,j,3);
        %
        %         if((h > 0 && h < 35) || (h > 325 && h < 360))
        %             if(s > 0.2 && s < 0.6)
        %                 if(v > 20)
        %                     final_image(i,j) = 1;
        %                     counter_skin = counter_skin + 1;
        %                 end
        %             end
        %         end
        
        %         if(h > 5 && h < 35)
        %             final_image(i,j) = 1;
        %             counter_skin = counter_skin + 1;
        %         end
        
        if(h > 0 && h < 50  && s >= 0.23 && s <= 0.68) 
            final_image(i,j) = 1;
            counter_skin = counter_skin + 1;
        else
            img(i,j,1) = 0;
            img(i,j,2) = 0;
            img(i,j,3) = 0;
        end
    end
end

figure,imshow(img);