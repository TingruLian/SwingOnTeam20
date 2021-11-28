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
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        NavigationView{
            ZStack{
                // Camera preview area
                CameraPreview(camera: camera)
                    .ignoresSafeArea(.all,edges: .all)
            }
            .onAppear(perform: {
                camera.checkPermissions()
            })
        }
        //.navigationBarTitle(<#T##SwiftUI.Text#>)
    }
}

struct VideoViewer_Previews: PreviewProvider {
    static var previews: some View {
        VideoViewer()
    }
}
