function [final_image,counter_skin] = colorYCbCr(img)

counter_skin = 0;

YCbCr = getYCbCr(img);

final_image = zeros(size(YCbCr,1), size(YCbCr,2));

for i = 1:size(YCbCr,1)
    for j = 1:size(YCbCr,2)
        
        y = YCbCr(i,j,1);
        cb = YCbCr(i,j,2);
        cr = YCbCr(i,j,3);
%         
%         if( y > 85 )
%             if(cb > 85 && cb < 140)
%                 if(cr > 140 && cr < 180)
%                     final_image(i,j) = 1;
%                     counter_skin = counter_skin + 1;
%                 end
%             end
%         end
%         
        if(cb > 102 && cb < 128)
                    final_image(i,j) = 1;
                    counter_skin = counter_skin + 1;
        end
        
        
    end
end