//
//  ContentView.swift
//  StayAhead
//
//  Created by Ajay Sharma on 2019-12-17.
//  Copyright © 2019 MrGoose. All rights reserved.
//

import SwiftUI
import GoogleMaps
import MapKit

//MKMapView().convert(<#T##point: CGPoint##CGPoint#>, toCoordinateFrom: <#T##UIView?#>)

struct ContentView: View {
    @State var setStart: Bool
    @State var setEnd: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    MapView(setStart: self.setStart, setEnd: self.setEnd)
                }
                
            
                
                
                HStack {
                    Button(action: {
                        self.setStart = true
                        self.setEnd = false
                        print("start")
                    }) {
                       Text("Start")
                    }
                    
                    Button(action: {
                        self.setEnd = true
                        self.setStart = false
                        print("end")
                    }) {
                       Text("End")
                    }
                    Text("Arrival Time")
                }
                .padding(.bottom, geometry.size.height/3)
            }
            
        }
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(setStart: true, setEnd: false)
    }
}
