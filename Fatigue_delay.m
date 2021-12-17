%If the camera remains on, type clear all to the Command Window, then you can delete it with clc!


%Cascade detector is preparing for facial detection.
dedectorFace = vision.CascadeObjectDetector();

% Tracking of the squares from the clotting algorithm is achieved. 
% The distance-based error rate in the corresponding piques in the squares is specified.
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);


% The image is obtained from the camera. Camera quality affects detection.
%It is available if the phone camera is better with an app like droidcam.
% cam = webcam (2); The image is taken from the second camera.
cam = webcam(1);

% The system waits until the person is perceived.
while true
    
    disp('Look at the camera to appear in your eyes and face.')
    pause(3)
    videoFrame = snapshot(cam);
    frameSize = size(videoFrame);

    try
        dedectorEye
        initialValue = ratio;
        thresholdValue = initialValue*0.98; 
        break
    catch exception
        disp('Any person could not be detected. Please take image again.')
    end
end
% The video window is created after the person is detected.
videoPlayer = vision.VideoPlayer('Position', [100 100 [frameSize(2), frameSize(1)]+30]);
    
time=0;
runLoop = true; % The loop runs continuously because TRUE is called.

while runLoop 

    % As the loop continues, the image is taken from the camera.
    videoFrame = snapshot(cam);
    
    %Warning music is prepared to steal 2 seconds. 2 value is used to change the time.
    warningSound = 'Alarm07.wav';
    [y,Fs] = audioread(warningSound);
    samples = [1,2*Fs];
    clear y Fs;
    [y,Fs] = audioread(warningSound,samples);
    

    try
        % With the first received frame, the rate in the current frame is compared..
        dedectorEye
        disp(['Current Value: ',num2str(ratio,3),' ,  Threshold Value: ',num2str(thresholdValue,3)])  ;      
        videoFrame = insertShape(videoFrame, 'rectangle', bbox, 'LineWidth', 3);
        
      % The rate from the detector is viewed. If it is smaller than the threshold, the time value increases and waits. 
      % When time 40 gives an eye closed warning. The expected time can be adjusted with 40 values.
        if ratio < thresholdValue
            statusEye='Open';
            result='Awake';
            disp(['You are ',result, ' eyestatus ',statusEye]);
            time = time+1;
            
            if time > 40
            statusEye='Close';
            result='Sleepy';
            disp(['You are ',result, ' eyestatus ',statusEye]);
            %Created BBOX features are added to the frame
            videoFrame = insertShape(videoFrame, 'rectangle', bbox, 'LineWidth', 3, 'Color', 'red');
            %The warning text is added to the frame
            text = 'Drowsiness';
            videoFrame = insertText(videoFrame, [frameSize(1) 0] , text, 'FontSize',18,'BoxColor', 'red' ,'BoxOpacity',0.4,'TextColor','white');
            sound(y,Fs);
            end
        else
            statusEye='Open';
            result='Awake';
            disp(['You are ',result, ' eyestatus ',statusEye]);
            time = 0;
        end
      
              
    catch exception
        disp('Could not be detected');
        sound(y,Fs);
    end
    
   
   
    % The video player appears with the created video frame.
    step(videoPlayer, videoFrame);
    % Oynat?c? penceresi aç?k m? kontrol edilir.
    runLoop = isOpen(videoPlayer);
end

% The values ??received when the player is on.
clear cam;
release(videoPlayer);
release(pointTracker);
release(dedectorFace);