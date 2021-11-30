//
//  CameraModel.swift
//  SwingOn
//
//  Created by Jessica Martinez Marquez on 11/20/21.
// Video
//

import AVFoundation
import SwiftUI
import Vision

class CameraModel: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate{
    
    // Create capture session
    var cameraFeedSession = AVCaptureSession()
    //var delegate: AVCapturePhotoCaptureDelegate?
    
    let output = AVCaptureVideoDataOutput()
    //var previewLayer: AVCaptureVideoPreviewLayer?
    
    // Set up queue - guarantees that video frames will be delivered in order
    let videoDataOutputQueue = DispatchQueue(label: "CameraFeedDataOutput", qos: .userInitiated,
                                                         attributes: [], autoreleaseFrequency: .workItem)
    var previewLayer: AVCaptureVideoPreviewLayer!
    var pointsLayer = CAShapeLayer()
    
    var bodyPoseRequest = VNDetectHumanBodyPoseRequest()
    
    let predictor = Predictor()
    
    func checkPermissions(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {[weak self] granted in guard granted else {return}
                // set up camera
                DispatchQueue.main.async {
                    self?.cameraSetUp()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            cameraSetUp()
            return
        @unknown default:
            break
        }
    }
    
    private func cameraSetUp(){
        //let session = AVCaptureSession()
        
        // Set up configuration done atomically
        cameraFeedSession.beginConfiguration()
        
        // Choose device --> rear camera
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        
        // Use device as input
        guard
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), cameraFeedSession.canAddInput(videoDeviceInput)
        else{return}
        cameraFeedSession.addInput(videoDeviceInput)
         
        // Add output
        if cameraFeedSession.canAddOutput(output){ 
            cameraFeedSession.addOutput(output)
            output.alwaysDiscardsLateVideoFrames = true 
            output.videoSettings = [
                String(kCVPixelBufferPixelFormatTypeKey): Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)
            ]
            output.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        }
        
        // Always process frames
        output.connection(with: .video)?.isEnabled = true
        cameraFeedSession.commitConfiguration()
        
        
//        // Set preview layer
//        previewLayer.videoGravity = .resizeAspectFill
//        previewLayer.session = session
        
        // Run capture session to start receiving video frames
//        session.startRunning()
//        cameraFeedSession = session
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Called when capture session is running. Receives buffer from camera stream
        
        // 1. Create request handler
        // 2. Perform request (VNDetectBody with handler
        // 3. VNDetectHumanBodyPoseRequest
        // ...
        
// -----
        print("captureOutput")
        predictor.displayBody(sampleBuffer: sampleBuffer)
// ----
        
        
        //var bodyPoseRequest = VNDetectHumanBodyPoseRequest()
//
//        let visionHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, options: [:])
//
//        do
//            // Body pose detection request
//            try visionHandler.perform([bodyPoseRequest])
//
//            guard let observation = bodyPoseRequest.results?.first
//            else{
//                print("no observation")
//                return
//            }
//
//           // let allpts = try observation.recognizedPoints(forGroupKey: VNRecognizedPointGroupKeyAll)
//            //let indexpts = try observation.recognizedPoints(.indexFinger)
//            //let indextip = indexpts[VNHumanHandPoseObservation.JointName.indexTip]
//            //print(indexpts.self)
//            // print(indextip!)
//            //let names = observation.availableJointNames
//            //print(names.self)
//
//          // let joints = getBodyJointsFor(observation: observation)
//           // print(joints)
//
//
//        } catch {
//            cameraFeedSession.stopRunning()
//            print("Unable to perform body pose detection request: \(error)")
//        }
        
        
    }
}


// To preview video on VideoViewer.swift
struct CameraPreview: UIViewRepresentable{
    var camera: CameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.previewLayer = AVCaptureVideoPreviewLayer(session: camera.cameraFeedSession)
        camera.previewLayer.frame = view.frame
        camera.previewLayer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.previewLayer)
        
        // new --> display joints
        camera.previewLayer.frame = view.frame
        view.layer.addSublayer(camera.pointsLayer)
        camera.pointsLayer.frame = view.frame
        camera.pointsLayer.strokeColor = UIColor.green.cgColor
        
        
        // Run capture session to start receiving video frames
        camera.cameraFeedSession.startRunning()
        
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

// new --> extend class
extension CameraModel: PredictorDelegate{
    func predictor(_predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint]) {
        guard let previewLayer = previewLayer else {
            print ("preview layer not initialized")
            return
        }
        
        let convertedPoints = points.map{
            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }
        
        let combinedPath = CGMutablePath()
        for point in convertedPoints{
            let dotPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 10, height: 10))
            combinedPath.addPath(dotPath.cgPath)
        }
        
        pointsLayer.path = combinedPath
        
//        DispatchQueue.main.async {
//            self.pointsLayer.didChangeValue(forKey: \.path)
//        }
    }
}

//struct CameraModel: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct CameraModel_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraModel()
//    }
//}
