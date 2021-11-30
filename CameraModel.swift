//
//  CameraModel.swift
//  SwingOn
//
//  Created by Jessica Martinez Marquez on 11/20/21.
// Video
//

import AVFoundation
import SwiftUI

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
        
        print("captureOutput")
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
        
        // Run capture session to start receiving video frames
        camera.cameraFeedSession.startRunning()
        
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
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
