# This file pulls and manages all dependencies of the project
# Using 'pod install' to run the project will generate a new workspace 
# called SwingOn.xcworkspace with all dependencies already loaded

platform :ios, '12.0'

# ignore all warnings from all pods
#inhibit_all_warnings!

target 'SwingOn' do
    # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!
  
    # Pods for PoseEstimation
    #pod 'TensorFlowLiteSwift', '~> 0.0.1-nightly', :subspecs => ['CoreML', 'Metal']
    pod 'TensorFlowLiteSwift', :subspecs => ['CoreML', 'Metal']

  end
