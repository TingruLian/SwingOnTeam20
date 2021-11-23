//
//  VideoAnalysis.swift
//  SwingOn
//
//  Created by Tina Lian on 11/22/21.
//

import Foundation
import UIKit
import AVFoundation
import Vision

// Get the CGImage on which to perform requests.

guard let cgImage = UIImage(named: "bodypose")?.cgImage else { return }

// Create a new image-request handler.
let requestHandler = VNImageRequestHandler(cgImage: cgImage)

// Create a new request to recognize a human body pose.
let request = VNDetectHumanBodyPoseRequest(completionHandler: bodyPoseHandler)

do {
    // Perform the body pose-detection request.
    try requestHandler.perform([request])
} catch {
    print("Unable to perform the request: \(error).")
}
func bodyPoseHandler(request: VNRequest, error: Error?) {
    guard let observations =
            request.results as? [VNHumanBodyPoseObservation] else {
        return
    }
    
    // Process each observation to find the recognized body pose points.
    observations.forEach { processObservation($0) }
}
func processObservation(_ observation: VNHumanBodyPoseObservation) {
    
    // Retrieve all torso points.
    guard let recognizedPoints =
            try? observation.recognizedPoints(.torso) else { return }
    
    // Torso joint names in a clockwise ordering.
    let torsoJointNames: [VNHumanBodyPoseObservation.JointName] = [
        .neck,
        .rightShoulder,
        .rightHip,
        .root,
        .leftHip,
        .leftShoulder
    ]
    
    // Retrieve the CGPoints containing the normalized X and Y coordinates.
    let imagePoints: [CGPoint] = torsoJointNames.compactMap {
        guard let point = recognizedPoints[$0], point.confidence > 0 else { return nil }
        
        // Translate the point from normalized-coordinates to image coordinates.
        return VNImagePointForNormalizedPoint(point.location,
                                              Int(imageSize.width),
                                              Int(imageSize.height))
    }
    
    // Draw the points onscreen.
    draw(points: imagePoints)
}
