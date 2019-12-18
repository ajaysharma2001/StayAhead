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
    let marker : GMSMarker = GMSMarker()
    @State var setStart: Bool
    @State var setEnd: Bool
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(start: $setStart)
    }
    
    let startTap = CLLocationCoordinate2DMake(43.47117332874348, -80.54760977625847)
    let endTap = CLLocationCoordinate2DMake(43.47350912482179, -80.54404780268669)
    

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
        
        //mapView.drawPolygon(from: startTap, to: endTap)

    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        
        @Binding var start: Bool
        
        init(start: Binding<Bool>) {
            _start = start
        }

        
        func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
            print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
            
            
            
            let marker = GMSMarker(position: coordinate)
            marker.title = "Start"
            if start {
                marker.icon = GMSMarker.markerImage(with: .red)
            }
            else {
                marker.icon = GMSMarker.markerImage(with: .blue)
            }
            marker.map = mapView
        }
        
    }

}





struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(setStart: true, setEnd: true)
    }
}

