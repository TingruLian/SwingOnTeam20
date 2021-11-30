//
//  LiveVideoAnalysis.swift
//  SwingOn
//
//  Created by Jessica Martinez Marquez on 11/28/21.
//
//
import UIKit
import Vision
import Foundation


//private let bodyPoseDetectionMinConfidence: VNConfidence = 0.6
//private let bodyPoseRecognizedPointMinConfidence: VNConfidence = 0.1


protocol PredictorDelegate: AnyObject {
    func predictor(_predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint])
}

class Predictor {
    
    weak var delegate: PredictorDelegate?
    var bodyPoseRequest = VNDetectHumanBodyPoseRequest()
    
func displayBody(sampleBuffer: CMSampleBuffer){
    
  //  print("displaybody")
    /// >> Body Pose Request
    // Request image handler for video
    let visionHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, options: [:])
    
    // New request to recognize human body pose - VNDetectHumanBodyPoseRequest
    do {
        // Perform body pose detection request
        try visionHandler.perform([bodyPoseRequest])
        
        /// >> Processing results
        // Retrieve observations
        guard let observation = bodyPoseRequest.results?.first
        else{
            print("no observation")
            return
        }
        
        let joints = getBodyJointsFor(observation: observation)
        print(joints.first!)
        
        // Process each observation to find the recognized body pose points
        let valuesArray = Array(joints.values)
        print(valuesArray)
        
        // Display points
        delegate?.predictor(_predictor: self, didFindNewRecognizedPoints: valuesArray)
        
    } catch {
        print("Unable to perform body pose detection request: \(error)")
    }
    
    
}

///// >> Processing results
//// Retrieve observations
//// Process each observation to find the recognized body pose points
//
///// >> Retrieve points of interest
////


/// Helper functions

let jointsOfInterest: [VNHumanBodyPoseObservation.JointName] = [
    .rightWrist,
    .rightElbow,
    .rightShoulder,
    .rightHip,
    .rightKnee,
    .rightAnkle,
    .leftWrist,
    .leftElbow,
    .leftShoulder,
    .leftHip,
    .leftKnee,
    .leftAnkle
]

// Fetch specific body joints
func getBodyJointsFor(observation: VNHumanBodyPoseObservation) -> ([VNHumanBodyPoseObservation.JointName: CGPoint]) {
    var joints = [VNHumanBodyPoseObservation.JointName: CGPoint]()
    guard let identifiedPoints = try? observation.recognizedPoints(.all) else {
        return joints
    }
    for (key, point) in identifiedPoints {
        guard point.confidence > 0.1 else { continue }
        if jointsOfInterest.contains(key) {
            joints[key] = point.location
        }
    }
    return joints
}

}
