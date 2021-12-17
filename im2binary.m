%Examples: rgb to binary

cam = webcam();
dedectorEye=vision.CascadeObjectDetector('EyePairBig');
EyeBBOX =step(dedectorEye,snapshot(cam));
originalBW = imcrop(snapshot(cam),EyeBBOX);
originalBW = im2bw(originalBW,0.4);
imshow(originalBW);