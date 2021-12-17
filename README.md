# Fatigue-Detector
According to the eye open or off, it detects the status of the drowsiness on MATLAB.
Created by developing the Vincent Tatan's repo on the link. Instead of giving a direct alarm in the case of the eyes closed, the possibility of blink is considered.
After a certain period of time, the Tatan's repo changed to give warning if the eyes are still off.
[Link](https://github.com/VincentTatan/DrowsinessDetectionSystem?source=post_page-----28a9903015f3---------------------- "link")

## Introduction
The driver is a simple adaptation of fatigue detection. The face received from the camera, before the face, then the eyes are detected. 
It gives the drowness warning on the screen and audible warning, according to the open or closed of the eyes.

## How Does It Work?
The image received from the camera is first detected with Haar Cascade. Then again with Haar Cascade with eyes. The area where the eyes are cropped. 
The image obtained is converted to binary format. The close morphological process is applied on. Then looked at the ratio of black and white pixels in the image. 
The ratio change by the eye open or off.

With the operation of the code, the eye will be expected clearly in the frame to be taken. The rate received from the first frame is determined as threshold value. 
Then the status of the eye is detected by comparing the rate in the current frame with the threshold value. Warning if the eye is closed for a specified period of time.
The image will also be warning if the person is lost. **Details are available in codes.**

We have 5 files available. Two files of morphological operations used.
Files necessary to work: [Fatigue_delay](../blob/main/Fatigue_delay.m)
                         [dedectorEye](../blob/main/dedectorEye.m)
                         [Alarm](../blob/main/Alarm.wav)

## Let's See the Results

![Awake](../main/images/awake.png "Status: Awake")
![Sleepy](../main/images/sleepy.png "Status: Sleepy")
