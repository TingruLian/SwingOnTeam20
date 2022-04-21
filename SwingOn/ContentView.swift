//
//  ContentView.swift
//  SwingOn by EC463 Team 20
//  Created on 10/29/21.
//

import SwiftUI
import PhotosUI
import MapKit
import AVKit


struct ContentView: View{
    var body: some View{
        TitleView()
//        HomeView()
        
    }
}

struct HomeView: View {
    
    @StateObject private var viewModel = MapViewModel()
    @State private var isShowingConfirmation = false
    @State private var isShowingPhotoPickerModel = false
    
    let Feeback = FeedBack()
    
    var body: some View {
        NavigationView {
            VStack {
            // Map is commented out for testing purposes
//                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
//                    .disabled(true)
//                    .ignoresSafeArea(.container, edges: .top)
//                    .accentColor(Color(.systemBlue))
//                    .onAppear {
//                        viewModel.checkIfLocationServicesIsEnabled()
//                    }
            
                Spacer()
          
                NavigationLink(destination: VideoViewer()) {
                    Text("Open camera")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(.orange)
                .cornerRadius(13)
                //.shadow(color: .orange.opacity(0.5), radius: 10, x: 0, y: 5)
                .padding(.horizontal)
                
                
                Button {
                    isShowingConfirmation = true
                } label: {
                    Text("Upload Video")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(.orange)
                .cornerRadius(13)
                //.shadow(color: .orange.opacity(0.5), radius: 10, x: 0, y: 5)
                .padding()
                .confirmationDialog("Choose a video source", isPresented: $isShowingConfirmation, titleVisibility: .visible) {
                    
                    
                    // original:
//                    Button("Camera", action:{})
                    
                    Button("Upload from Photos", action: {
                        isShowingPhotoPickerModel = true
                        Feeback.speak(_phrase: "Upload from Photos")
                    })
                    Button("Upload from Files", action: {
                        Feeback.speak(_phrase: "Upload from Files")
                    })
                }
                
                Spacer()
                
//                // This works:
//                NavigationLink(destination: SecondView()) {
//                            Text("Press on me")
//                         }.buttonStyle(PlainButtonStyle())
                
            }
            .sheet(isPresented: $isShowingPhotoPickerModel, content: {
                PhotoPickerModel()
            })
            
        }
    }
}

struct BulletText: View{
    
    var number: String
    var text: String
    
    var body: some View {
        
        HStack{
            ZStack{
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.orange)
                    
                Text(number)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
            }
            
            Text(text)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.leading, 20)
        }
        .padding(.bottom, 30).padding(.horizontal, 70)
        
    }
}

struct TitleView: View {
    
    var body: some View {
        
        NavigationView {
        VStack{
            VStack(alignment: .leading){
                    Text("Welcome to")
                        .font(.system(size: 40))
                        .fontWeight(.black)
                        .foregroundColor(Color.black)
                        
                    Text("SwingOn!")
                        .font(.system(size: 40))
                        .fontWeight(.black)
                        .foregroundColor(.orange)
                }
                .padding(.top, -10).padding(.bottom, 50)
            
            
            VStack(alignment: .leading){
                
                BulletText(number: "1", text: "Open the camera or choose a video")
                
                BulletText(number: "2", text: "Analyze your golf swing")
                
                BulletText(number: "3", text: "Get feedback of your swing")
                
                BulletText(number: "4", text: "SwingOn!")
                
            }
            NavigationLink(destination: HomeView().navigationBarHidden(true)){
                    Text("Get Started")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 200, maxHeight: 50)
                .background(.orange)
                .cornerRadius(13)
                //.shadow(color: .orange.opacity(0.5), radius: 10, x: 0, y: 5)
                .padding(.horizontal).padding(.vertical, 30)
          
 
        } //VStack
        } //NavigationView
    }
}


class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

//struct SecondView: View {
//    var body: some View {
//       // VStack {
//            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//       // }
//    }
//}

