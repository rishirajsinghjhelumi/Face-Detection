function [rgbOutputImage] = increaseBrightness(rgbInputImage)
    
 labInputImage = applycform(rgbInputImage,makecform('srgb2lab'));      %%%%%    converts rgb colorspace to La*b* colorspace and apply to input image %%%%%
%  figure,imshow(labInputImage);
 Lbpdfhe = fcnBPDFHE(labInputImage(:,:,1));                            %%%%% Enhance Contrast while maintaining brightness (Histogram equalisation)%%%%%
 
 labOutputImage = cat(3,Lbpdfhe,labInputImage(:,:,2),labInputImage(:,:,3)); %%%%% concatanate unchanged 2 arrays with changed Lbpdfhe array %%%%% 
%  figure,imshow(labOutputImage);
 rgbOutputImage = applycform(labOutputImage,makecform('lab2srgb'));    %%%%% converts rgb colorspace to La*b* colorspace and apply to input image %%%%%