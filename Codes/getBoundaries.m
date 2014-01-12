function [boundaries,considerPeople] = getBoundaries(rgbInputImage,numberOfPeople,binaryImage)

imagesc(rgbInputImage);
title('Boundary Outlines');
axis square;
hold on;
boundaries = bwboundaries(binaryImage);
considerPeople = zeros(1,numberOfPeople);

for k = 1 : numberOfPeople
   thisBoundary = boundaries{k};
    
    minx = min(thisBoundary(:,1));
    maxx = max(thisBoundary(:,1));
    miny = min(thisBoundary(:,2));
    maxy = max(thisBoundary(:,2));
    
    ratio = (maxy - miny)*1.0 / (maxx - minx);
    if( (1.0 / ratio) > 2.9)
        considerPeople(k) = 1;
    end
    
    plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
end
hold off;

figure,imshow(rgbInputImage);
