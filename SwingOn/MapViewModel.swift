//
//  MapViewModel.swift
//  SwingOn by EC463 Team 20
//  Created on 11/16/21.
//

import MapKit
import SwiftUI

enum MapDetails {
    
    static let startingLocation = CLLocationCoordinate2D(latitude: 42.3493705376, longitude: -71.1064123842)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }
        else {
            print("Show an alert letting them know this is off and to go turn it on.")
        }
    }
    
    private func checkLocationAuthorization() {
        
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Alert(title: Text("Location Restricted"), message: Text("Your location is restricted."))
            print("Your location is restricted likely due to parental controls")
        case .denied:
            // Alert(title: Text("Location Permission Denied"), message: Text("Your location is restricted."))
            print("You have denied this App location permission. Go into Settings and change it")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
