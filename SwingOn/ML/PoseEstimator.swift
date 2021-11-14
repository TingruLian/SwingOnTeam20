//
//  PoseEstimator.swift
//  SwingOn
//
//  Created by Jessica Martinez Marquez on 11/14/21.

import UIKit

/// Protocol to  run a pose estimator.
protocol PoseEstimator {
  func estimateSinglePose(on pixelbuffer: CVPixelBuffer) throws -> (Person, Times)
}

// MARK: - Custom Errors
enum PoseEstimationError: Error {
  case modelBusy
  case preprocessingFailed
  case inferenceFailed
  case postProcessingFailed
}
