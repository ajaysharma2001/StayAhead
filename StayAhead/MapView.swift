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

var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2DMake(0, 0), CLLocationCoordinate2DMake(0, 0)]
var travelTime: String = "____________"

struct MapView: UIViewRepresentable {
    let marker : GMSMarker = GMSMarker()
    @State var setStart: Binding<Bool>
    @State var setEnd: Binding<Bool>
    @State var travelTime: Binding<String>
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(start: setStart, time: travelTime)
    }
    
    

    /// Creates a `UIView` instance to be presented.
    func makeUIView(context: Self.Context) -> GMSMapView {

        
        let camera = GMSCameraPosition.camera(withLatitude: 43.47, longitude: -80.548, zoom: 14.5)
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
        @Binding var time: String
        
        init(start: Binding<Bool>, time: Binding<String>) {
            _start = start
            _time = time
        }
        

        
        func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
            
            mapView.clear()

            if start {
                points[0] = coordinate
                
            }
            else {
                points[1] = coordinate
            }
            
            let startMarker = GMSMarker(position: points[0])
            let endMarker = GMSMarker(position: points[1])
            
            startMarker.title = "Start"
            endMarker.title = "End"
            
            startMarker.icon = GMSMarker.markerImage(with: .blue)
            endMarker.icon = GMSMarker.markerImage(with: .red)
            
            startMarker.map = mapView
            endMarker.map = mapView
            
            if (!(points[0].latitude == 0) && !(points[0].longitude == 0) && !(points[1].latitude == 0) && !(points[1].longitude == 0)) {
                
                
                
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)

                let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(points[0].latitude),\(points[0].longitude)&destination=\(points[1].latitude),\(points[1].longitude)&sensor=false&mode=walking&key=AIzaSyBkeE_oo-UBzD4_10zxtCzsHO22G2GFQ34")!

                let task = session.dataTask(with: url, completionHandler: {
                    (data, response, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        do {
                            if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {

                                let preRoutes = json["routes"] as! NSArray
                                let routes = preRoutes[0] as! NSDictionary
                                let legs = routes["legs"] as! NSArray
                                let info = legs[0] as! NSDictionary
                                let duration = info["duration"] as! NSObject
                                print(duration.value(forKey: "text") as! String)
                                self.time = duration.value(forKey: "text") as! String
                                let routeOverviewPolyline:NSDictionary = routes.value(forKey: "overview_polyline") as! NSDictionary
                                let polyString = routeOverviewPolyline.object(forKey: "points") as! String

                                DispatchQueue.main.async(execute: {
                                    let path = GMSPath(fromEncodedPath: polyString)
                                    let polyline = GMSPolyline(path: path)
                                    polyline.strokeWidth = 5.0
                                    polyline.strokeColor = UIColor.green
                                    polyline.map = mapView
                                })
                            }

                        } catch {
                            print("parsing error")
                        }
                    }
                })
                task.resume()
            }
                
        }
        
    }

}




/*
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(setStart: $Bool, setEnd: Binding<true>)
    }
}

*/
