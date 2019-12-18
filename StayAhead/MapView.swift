//
//  MapView.swift
//  StayAhead
//
//  Created by Ajay Sharma on 2019-12-17.
//  Copyright © 2019 MrGoose. All rights reserved.
//

import SwiftUI
import GoogleMaps
import UIKit
import MapKit

struct MapView: UIViewRepresentable {
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator()
    }
    
    let marker : GMSMarker = GMSMarker()
    @State var setStart: Bool
    @State var setEnd: Bool
    
    let startTap = 250
    let endTap = 250
    

    /// Creates a `UIView` instance to be presented.
    func makeUIView(context: Self.Context) -> GMSMapView {
        
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.

        
        let camera = GMSCameraPosition.camera(withLatitude: 43.477768, longitude: -80.555584, zoom: 14.5)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        mapView.delegate = context.coordinator
        return mapView
    }
    

    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        // Creates a marker in the center of the map.
        
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        }
        
    }

}



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(setStart: true, setEnd: true)
    }
}

