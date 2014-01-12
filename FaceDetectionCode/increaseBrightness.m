function [rgbOutputImage] = increaseBrightness(rgbInputImage)
    
 labInputImage = applycform(rgbInputImage,makecform('srgb2lab'));
 Lbpdfhe = fcnBPDFHE(labInputImage(:,:,1));
 labOutputImage = cat(3,Lbpdfhe,labInputImage(:,:,2),labInputImage(:,:,3));
 rgbOutputImage = applycform(labOutputImage,makecform('lab2srgb'));