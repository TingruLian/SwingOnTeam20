//
//  CameraModel.swift
//  SwingOn
//
//  Created by Jessica Martinez Marquez on 11/20/21.
// Video
//


//import SwiftUI
import AVFoundation
import SwiftUI

class CameraModel: ObservableObject{
    
    // Create capture session
    var cameraFeedSession = AVCaptureSession()
    //var delegate: AVCapturePhotoCaptureDelegate?
    
    let output = AVCaptureVideoDataOutput()
    //var previewLayer: AVCaptureVideoPreviewLayer?
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
        }
        
//        // Set preview layer
//        previewLayer.videoGravity = .resizeAspectFill
//        previewLayer.session = session
        
        // Run capture session to start receiving video frames
//        session.startRunning()
//        cameraFeedSession = session
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
