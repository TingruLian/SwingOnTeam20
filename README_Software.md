# SwingOn Software
## Development and Build Tools
- XCode 13: IDE
- Swift: app programming language
- SwiftUI: UI framework
- TensorFlow PoseNet: pose detection
- Python: ML models programming language

## Installation 
### Prerequisites

#### Hardware
To run and simulate the prototype:
- A device running on iOS 15 or iPadOS 15
- A computer running macOS Catalina (or later)

#### Software
- XCode 13
- SwiftUI
- Tensorflow PoseNet
- CoreML

##### Recommended set up:
- macOS Monterey (>=12.3.1)
- XCode 13 (>=13.3.1)
- iOS 15 (>=15.4.1)

### To run
Connect the device to the a supported computer running MacOS. On the menu bar go to Product > Destination to select the connected device. Then run the application by going to Product > Run (`Command + R`)

## Block Diagram
![blockdiagram](https://user-images.githubusercontent.com/56104192/166063936-91d03c5e-ccf8-4e62-a58e-225d50805660.png)

The front end uses Swift UI. When a user first opens the app, his or her location will be displayed on the main screen. 
On the second screen, the user can choose "Open Camera" or "Upload from Files" which are the two options for video origin: “Upload from files” and “Upload from Photo Library." Once the user chooses the video input, the data will be fed into the machine learning models which are integrated onto the device with CoreML. After using machine learning algorithms for the data, feedback is given back to the user.


## Map
MapKit framework is used to display maps within the app. Due to privacy concerns, the user needs to enable location services when opening the app for the first time.

  - Display map information: Map API is used to get users’ locations 

  - Authorization status: Users need to authorize the app in order to use location services. The Location services must be enabled for their phone, which they can turn on in Settings > Privacy. The users will be asked if they allow SwingOn to use their locations. And there will then be three choices which are: “Allow Once”, “Allow while using the App”, and “Don’t Allow”. Users can also change their choices in Settings > Privacy > Location Services > SwingOn.



## Camera - CameraModel.swift
AVFoundation is a multimedia framework in Swift to allow access to all the media devices on the iPhone. This framework combines six major technology areas for capturing, processing, synthesizing, controlling, importing, and exporting audiovisual media on Apple platforms. Many tasks can be completed using this framework in our app. 

  - AV Capture Session is an object in the framework that allows management of capture activity as well as coordinating the flow of data from input devices to capture outputs. 
  
  - AVCaptureVideoDataOutput is a framework that allows access to video buffers from a live camera for processing
  
  - AVPlayer is a framework that allows users to view their uploaded videos. 
![b9c65b62-3728-43f1-8d25-08fd42bc6bb7](https://user-images.githubusercontent.com/90277008/165957655-9e0767f9-07b2-4701-b3d9-1e1a36f8656c.png)


## Upload videos from files
UIDocumentPickerViewController: It provides access to documents or destinations outside the app.

UIViewControllerRepresentable creates and manages a UIViewController object in SwiftUI interface. It updates the state of the specified view controller with new information from SwiftUI and makeCoordinator which creates the custom instance that can communicate changes from our view controller to other parts of our user interface.

UIImagePickerControllermanages the system interfaces for taking pictures, recording movies, and choosing items from the user's media library.

## Video analysis 
### CoreML
CoreML applies a machine learning algorithm to a set of training data to create a model. In this case, we use PoseNet to make predictions based on new input data. 
![renderedDark2x-1638462887](https://user-images.githubusercontent.com/90277008/165956344-00e41122-a48d-461e-b7be-c72f6abeaca0.png)

### PoseNet Thunder
PoseNet：Pretrained model for human body detection. It takes a processed camera image as the input and outputs 17 body keypoints. It uses GoogLeNet architecture which contains 22 layers. The network is a real-time pose detection technique with which we can detect human beings’ poses in Image or Video.
![rendered2x-1586365563](https://user-images.githubusercontent.com/90277008/165956891-c038d3a7-06f3-4315-8da6-45817a467985.png)


### Algorithm
#### Methods
- Centroid: It is the center of mass calculated by analyzing the following detected body points: shoulders and hips (right and left). The centroids at each frame from all the frames in the video as a time series have been found and plotted. The curves of best fit for the centroids to analyze the balance of the golfer was also calculated in the algorithm.

- Hip Rotation: It is the degree the golfer rotates his or her waist during the swing by finding the angle of the current waistline at initial position. The hip rotation at each frame of the video have been found and calculated.

- Leading hip and ankle rotation: This is another method to find out if a golfer is balanced or not. The leading hip and ankle of the golfer and calculated the angle between this line and a vertical line to find out the regress of rotation.

#### Models
- Multidimensional Scaling (MDS): MDS of Euclidean distance allows visualization of the level of similarity of individual cases in the centroid dataset.

- K-means: Unsupervised classification algorithm that can group objects based on their characteristics. In the algorithm, the centroid points of the golfer in each video was used as the data to classify.
