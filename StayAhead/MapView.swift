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

struct MapView: UIViewRepresentable {
    let marker : GMSMarker = GMSMarker()
    @State var setStart: Binding<Bool>
    @State var setEnd: Binding<Bool>
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(start: setStart)
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
            
            startMarker.icon = GMSMarker.markerImage(with: .red)
            endMarker.icon = GMSMarker.markerImage(with: .blue)
            
            startMarker.map = mapView
            endMarker.map = mapView
            
            if (!(points[0].latitude == 0) && !(points[0].longitude == 0) && !(points[1].latitude == 0) && !(points[1].longitude == 0)) {
                
                let origin = "\(points[0].latitude),\(points[0].longitude)"
                let destination = "\(points[1].latitude),\(points[1].longitude)"

                let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyBkeE_oo-UBzD4_10zxtCzsHO22G2GFQ34"

                let url = URL(string: urlString)
                URLSession.shared.dataTask(with: url!, completionHandler: {
                    (data, response, error) in
                    if(error != nil){
                        print("error")
                    }else{
                        do{
                            let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                            let routes = json["routes"] as! NSArray
                            mapView.clear()

                            OperationQueue.main.addOperation({
                                for route in routes
                                {
                                    let routeOverviewPolyline:NSDictionary = (route as! NSDictionary).value(forKey: "overview_polyline") as! NSDictionary
                                    let points = routeOverviewPolyline.object(forKey: "points")
                                    let path = GMSPath.init(fromEncodedPath: points! as! String)
                                    let polyline = GMSPolyline.init(path: path)
                                    polyline.strokeWidth = 3

                                    let bounds = GMSCoordinateBounds(path: path!)
                                    mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))

                                    polyline.map = mapView

                                }
                            })
                        }catch let error as NSError{
                            print("error:\(error)")
                        }
                    }
                }).resume()
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
