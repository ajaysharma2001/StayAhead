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
                MapView(setStart: self.$setStart, setEnd: self.$setEnd)

                HStack {
                    Spacer()
                    Button(action: {
                        self.setStart = true
                        self.setEnd = false
                    }) {
                        HStack {
                            Image("start")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("Start")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(40)
                    }
                    
                    Button(action: {
                        self.setEnd = true
                        self.setStart = false
                    }) {
                        HStack {
                            Image("end")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("End")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.white]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(40)
                    }
                    Text("Arrival Time")
                    Spacer()

                }
                
            }
            
        }
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(setStart: true, setEnd: false)
    }
}
