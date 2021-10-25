%% Read a video frame by frame
% Read a video frame 
videoReader = VideoReader('swing.mp4');
videoPlayer = vision.VideoPlayer;
frames = videoReader.NumFrames; %number of frames
% play the video fram by frame
while hasFrame(videoReader)
   frame = readFrame(videoReader); %read next frame
   step(videoPlayer,frame);
end
%% Detect head 
% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector('UpperBody'); %can only do upper body because head can not be detected
faceDetector.MinSize = [150 150];
%read the first frame
videoFrame = read(videoReader,1); 
bbox = step(faceDetector, videoFrame);
% Draw the returned bounding box around the detected face.
label_str =strcat ('Head position x: ' ,num2str(bbox(1),'%d'),' y:' ,num2str(bbox(2),'%d'));
videoFrame = insertObjectAnnotation(videoFrame, 'Rectangle', bbox,label_str);
imshow(videoFrame); title('Detected head of the first frame of the video');

