# Golf_Swing (SwingOn)
Senior Design Team 20

## Team Members:

- Yoel Beyene (yoelb@bu.edu)
- Tingru Lian (tinalian@bu.edu)
- Hanlin Mai (hanlinm@bu.edu)
- Jessica Martinez Marquez (jessmtzm@bu.edu)

## VIdeo
https://youtu.be/oSQ9YKRs6xs

## Vision and Goals of Project
The goal of this project is to create a golf swing improver that focuses on concentration, balance, and consistency. SwingOn is a cross-platform mobile APP that tracks the motions of the golfer in real-time. Motion sensors may be used to detect the golfer’s actions. Multiple factors of the golfer will be monitored, including body motion detection and head rotation. Data of the golfer’s motion will be recorded, stored and analyzed to calculate the golfer's consistency of their swing as well as to keep a record of their improvement over time. MATLAB will be used for video processing and React Native for developing the front-end of the APP.


## APP
The APP will be created using Swift UI. 
Swift is a powerful and intuitive programming language for iOS, iPadOS, macOS, tvOS, and watchOS. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and Swift includes modern features developers love. Swift code is safe by design, yet also produces software that runs lightning-fast.

![image](https://user-images.githubusercontent.com/90277008/141120953-aca2749f-c66d-41c9-b61a-e66a547edc63.png)


## Algorithm
For detecting the centroid of a person, body landmarks will be detected, which includes nineteen body points. This is using the Vision Framework. The Vision framework performs face and face landmark detection, text detection, barcode recognition, image registration, and general feature tracking. Vision also allows the use of custom Core ML models for tasks like classification or object detection.

![image](https://user-images.githubusercontent.com/90277008/141121033-091a6b93-2e1c-45dd-b431-a6166b527162.png)


## APIs

## Build and Run

Prerequisites:
1. Cocoapods ``` sudo gem install cocoapods ```

To Run:
1. Run on Terminal ``` pod install ```. If there are issues run ``` pod update ``` first.
2. Open ``` SwingOn.xcworkspace ```
