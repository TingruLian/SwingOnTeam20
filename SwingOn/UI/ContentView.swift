//
//  ContentView.swift
//  SwingOn
//
//  Created on 10/29/21.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.349370537576355, longitude: -71.10641238421073), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        VStack {
            
            Map(coordinateRegion: $region, showsUserLocation: true)
                .frame(height: UIScreen.main.bounds.height - 300)
                .disabled(true)
            
            Spacer()
            
            Button(
                action: {
                    print("Hello")
                },
                label: {
                    HStack {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Spacer()
                        Text("Open Camera")
                            .font(.headline)
                        Spacer()
                    }
                }
            )
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(.gray)
            .foregroundColor(.white)
            .buttonStyle(.bordered)
            .cornerRadius(13)
            .padding(.horizontal)
            
            Button(
                action: {
                    print("Hello")
                },
                label: {
                    HStack {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Spacer()
                        Text("Upload from Library")
                            .font(.headline)
                        Spacer()
                    }
                }
            )
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(.gray)
            .foregroundColor(.white)
            .buttonStyle(.bordered)
            .cornerRadius(13)
            .padding(.horizontal)
            
            Button(
                action: {
                    print("Hello")
                },
                label: {
                    HStack {
                        Image(systemName: "folder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Spacer()
                        Text("Upload from Files")
                            .font(.headline)
                        Spacer()
                    }
                }
            )
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(.gray)
            .foregroundColor(.white)
            .buttonStyle(.bordered)
            .cornerRadius(13)
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var images: [UIImage]
    @Binding var picker: Bool
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent1: self)
    }
    
    class Coordinator: NSObject,PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(parent1: ImagePicker) {
            parent = parent1
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            parent.picker.toggle()
            
            for img in results {
                if img.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    img.itemProvider.loadObject(ofClass: UIImage.self) {
                        (image, err) in guard let image1 = image
                        else {
                            print(err)
                            return
                        }
                        self.parent.images.append(image as! UIImage)
                    }
                }
                
                else {
                    print("cannot be loaded")
                }
            }
        }

    }
}
