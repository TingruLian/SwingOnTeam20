//
//  VideoViewer.swift
//  SwingOn
//
//  Created by Jessica Martinez Marquez on 11/20/21.
//
// Screen to visualize video
//

import SwiftUI

struct VideoViewer: View {
    @StateObject var camera = CameraModel()
//    @ObservedObject
    var player = Predictor().playerDetected
    
    
//    @State var show = false // needs to change to observed object so that message pop ups when there is a player
    
  
    
    var body: some View {
        NavigationView{
            ZStack{
// MARK: Camera preview area
                CameraPreview(camera: camera)
                    .ignoresSafeArea(.all,edges: .all)
                
//                Color.white
//                    .ignoresSafeArea(.all,edges: .all)
//                    .navigationBarHidden(true)
                
                // For testing notice
                
            
//                VStack{
//                Button("Show"){
//                    withAnimation{
//                        show.toggle()
//                    }
                //}
                let _ = print("vv player: \(player)")
                if !player {
                    VStack{
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .font(.system(size: 48, weight: .regular))
                            .padding(EdgeInsets(top: 20, leading: 5, bottom: 5, trailing: 5))
                        Text("Player Detected")
                            .foregroundColor(.white)
                            .font(.callout)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                    }
                    .background(Color.gray.opacity(0.75))
                    .cornerRadius(5)
//
////                    Rectangle()
////                        .fill(.red)
////                        .frame(width: 200, height: 200)
////                        .transition(.opacity)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.easeOut){
//                              show.toggle()
                            }
                        }
                    }
                } // if show
//                else { // feedback "no player detected"
////                    Feeback.speak(_phrase: "Upload from Photos")
//
//                }
                    
//                } //VStack
                
//                RoundedRectangle(cornerRadius: 30)
//                    .fill(Color.blue)
//                    .padding()
//                    .animation(.easeOut(duration: 2).delay(0.5), value: show)
//                    .onAppear {
//                        show.toggle()
//                    }
                    
                
                
                
//                VStack{
//                    Spacer()
//
//                    Button(action: {
//                        print("Taking Picture")
//                    }, label: {
//                        ZStack{
//                            Circle().frame(width: 65, height: 65)
//                                .foregroundColor(.orange)
//                            Circle().stroke(Color.white, lineWidth: 4)
//                                .frame(width: 75, height: 75)
//                        }
//                    })
//                } //VStack
            } // ZStack
//            .onTapGesture {
//                       withAnimation(.spring()) {
//                           show.toggle()
//                       }
//            }
            .onAppear(perform: { camera.checkPermissions() })
            .onDisappear(perform: { camera.closeCamera() })
             
            
        //.navigationBarTitle(<#T##SwiftUI.Text#>)
    }
        
}
}

struct VideoViewer_Previews: PreviewProvider {
    static var previews: some View {
        VideoViewer()
    }
}
