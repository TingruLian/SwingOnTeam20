# SwingOn
BU ECE Senior Design Team 20

## Client:
- Professor Martin Herbordt

## Team Members:

- Yoel Beyene (yoelb@bu.edu)
- Tingru Lian (tinalian@bu.edu)
- Hanlin Mai (hanlinm@bu.edu)
- Jessica Martinez Marquez (jessmtzm@bu.edu)


## Video

- First semester PDR: https://youtu.be/oSQ9YKRs6xs


## Vision and Goals of Project

The goal of this project is to create a golf swing improver that focuses on balance and consistency. SwingOn is a native iOS app that tracks the motions of the golfer in real-time from live video or user uploaded videos.  Multiple factors of the golfer will be monitored, including body motion detection and balance. Data of the golfer’s motion will be recorded, stored and analyzed to calculate the golfer's balance and consistency of their swing as well as to keep a record of their improvement over time. 


## Scope and Features

- Takes two different kinds of input sources: live or user uploaded videos
- Finds the balance of the user
  - Detects key body points of the user's body to calculate their centroid
- Determines user's consistency
  - Calculates the change of the centroid's position over time
- Provides auditory feedback to user about quality of swing


### Application

The app will be created using Swift and SwiftUI for the front-end. Swift is a powerful and intuitive programming language for iOS, iPadOS, macOS, tvOS, and watchOS.

![image](https://user-images.githubusercontent.com/90277008/141120953-aca2749f-c66d-41c9-b61a-e66a547edc63.png)


### Algorithm

For detecting the centroid of a person, body landmarks will be detected, which includes nineteen body points. This is using the Vision Framework by Apple. The Vision framework performs body and face landmark detection, text detection, barcode recognition, image registration, and general feature tracking. Vision also allows the use of custom Core ML models for tasks like classification or object detection.



## Install Steps

Prerequisites:
1. XCode 13.1
2. iOS 15+ device 

To Run:
1. Clone this git repo
2. On Terminal, ``` open SwingOn.xcodeproj ``` 
3. With the device connected to the computer, go to Product > Destination > Find and choose your device
4. Go to Product > Run
5. On the device settings, go to Developer > Trust computer
