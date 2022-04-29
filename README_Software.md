# Software
## Dev/build tool information
###### Xcode
###### SwiftUI
###### TensorFlow
###### Python

## Installation
###### Prerequisites
###### To run

## Flow chart
![Block diagram](https://user-images.githubusercontent.com/90277008/165958257-38a1f301-b30a-49f6-b4c9-4a493ae16bc0.jpeg)
The front end is written using Swift UI. When a user first opens the app, his or her location will be displayed at the launch screen; Map API is used to determine the user’s location.  There are then different options from which  the user can choose. “Open Camera” connects to the Camera API, then “Upload from files” and “Upload from Photo Library” connect to the Video API. All of those API connect to Apple CPU, GPU and NPU. Then the data will go through machine learning models which CoreML uses to integrate. After using machine learning algrotherism for the data, feedback is given back to the user which shows at the front end. 


## Map
MapKit: framework that allows the display of map or satellite imagery within the app. It asks for authorization when first entering the aApp.

  - Display map information: Map API is used to get users’ locations 

  - Authorization status: Users need to authorize the app in order to use location services. The Location services must be enabled for their phone, which they can turn on in Settings > Privacy. The users will be asked if they allow SwingOn to use their locations. And there will then be three choices which are: “Allow Once”, “Allow while using the App”, and “Don’t Allow”. Users can also change their choices in Settings > Privacy > Location Services > SwingOn.


## Camera
AVFoundation framework: AVFoundation is a multimedia framework with APIs in Swift. It allows access to all the media devices on the iPhone. The AVFoundation combines six major technology areas for capturing, processing, synthesizing, controlling, importing, and exporting audiovisual media on Apple platforms. Many tasks can be completed using this framework in our App. 

  - AV Capture Session is an object in the framework that allows management of capture activity as well as coordinations of the flow of data from input devices to capture outputs. 
  
  - AVCaptureVideoDataOutput is a framework that allows access to video buffers from a live camera for processing
  
  - AVPlayer is a framework that allows users to view their uploaded videos. 
![b9c65b62-3728-43f1-8d25-08fd42bc6bb7](https://user-images.githubusercontent.com/90277008/165957655-9e0767f9-07b2-4701-b3d9-1e1a36f8656c.png)



## Upload videos from files
UIDocumentPickerViewController: It provides access to documents or destinations outside the app's sandbox.

UIViewControllerRepresentable creates and manages a UIViewController object in SwiftUI interface. It updates the state of the specified view controller with new information from SwiftUI and makeCoordinator which creates the custom instance that can communicate changes from our view controller to other parts of our user interface.

UIImagePickerControllermanages the system interfaces for taking pictures, recording movies, and choosing items from the user's media library.

## Video analysis 
###### CoroeML
CoreML applies a machine learning algorithm to a set of training data to create a model. In this case, we use PoseNet to make predictions based on new input data. 
![renderedDark2x-1638462887](https://user-images.githubusercontent.com/90277008/165956344-00e41122-a48d-461e-b7be-c72f6abeaca0.png)

PoseNet：Pretrained model for human body detection. It takes a processed camera image as the input and outputs 17 body keypoints. It uses GoogLeNet architecture for developing whihc contains 22 layers. The network is a real-time pose detection technique with which we can detect human beings’ poses in Image or Video.
![rendered2x-1586365563](https://user-images.githubusercontent.com/90277008/165956891-c038d3a7-06f3-4315-8da6-45817a467985.png)


###### Algorithm
Centroid: It is the center of mass calculated by analysis of detected body points. The centroids at each frame from all the frames in the video as a time series have been found and plotted.The curves of best fit for the centroids to analyze the balance of the golfer was also calculated in the algrotherism.

Hip Rotation: It is the degree the golfer rotates his waist during the swing by finding the angle of the current waistline to the on at initial position. The hip rotation at each frame of the video have been found and calculated.

Leading hip and ankle rotation: This is another method to find out if a golfer is balanced or not. The leading hip and ankle of the golfer and calculated the angle between this line and a vertical line to find out the regress of rotation.

Multidimensional Scaling (MDS): MDS of Euclidean distance allows visualization of the level of similarity of individual cases in the centroid dataset.

K-means: K-means is an unsupervised classification algorithm that can group objects based on their characteristics. In the algrotherism, the centroid points of the golfer in each video was used as the data to classify.

