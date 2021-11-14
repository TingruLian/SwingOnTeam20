# This file pulls and manages all dependencies of the project
# Using 'pod install' to run the project will generate a new workspace 
# called SwingOn.xcworkspace with all dependencies already loaded

platform :ios, '12.0'

target 'SwingOn' do
    use_frameworks!

    #Pods for PoseEstimation Tensorflow model
    pod 'TensorflowLiteSwift', '~> 0.0.1-nightly', :subspecs => ['CoreML', 'Metal']

end
