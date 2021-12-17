%Image is assigned to image variable
image=videoFrame;

% The Cascade Dedector is prepared for detecting the eyes. for two eyes
dedectorEyex =  vision.CascadeObjectDetector('EyePairBig');
 %Right or Left Eye alone can give better results
 %dedectorEyex =  vision.CascadeObjectDetector('LeftEyeCART');
 %mergethreshold. 6 Detection and gives 1 bounding box. 
 %Gives six BBOX's average. To the fact that the detection is guaranteed. Can be considered in the form.
dedectorEyex.MergeThreshold = 6;

% The eye detector is operated on image.
bbox =step(dedectorEyex,image);

%The eyes are marked on the image.
annotateye = insertObjectAnnotation(image,'rectangle',bbox,'Eye');

% The resulting frame obtained at the end of the detection is cropped. 
%The frames are fulminated forever (closing) to be taken forever (closing).

bbox=bbox(1,:);
imageEye = imcrop(image,bbox);

% Strel ile 3 boyutlu yap?land?rma elemani olusturulup morfolojik closing
% The 3D configuration element with Strel is created and the morphological closing is applied. 
%This process flattens strokes in the white section, combine small disconnections and fine transitions. 
%Finally destroys small holes. The binary passage may differ in the camera. 0.3 can be changed and fixed.
imageEyeBinary=im2bw(imageEye,0.3);
imageEyeClose=imclose(imageEyeBinary, strel('sphere',4));

%The total pixel values ??are taken with SUM. 
%Number of Numel and the number of pixels are taken and the ratio of black pixels are calculated with white pixels. 
%The odds are different if the eye is on and off. When the image is turned to Binary, 
%the values ??received are white pixels, the rest of the rest are black.
%The use of morphological transactions is beneficial.

whitePixel = sum(imageEyeClose);
x = sum(imageEyeClose);
blackPixel = numel(imageEyeClose) - whitePixel ;
y = numel(imageEyeClose);
ratio = blackPixel  / whitePixel;
