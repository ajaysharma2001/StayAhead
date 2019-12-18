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
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
    @State var selectedDate = Date()
    
    var body: some View {
        GeometryReader { geometry in
            //VStack - Map and User Area
            VStack {
                MapView(setStart: self.$setStart, setEnd: self.$setEnd)
                
                //HStack - Start & End Buttons
                HStack {
                    Spacer()
                    //Start Button
                    Button(action: {
                        //Do something here
                        self.setStart = true
                        self.setEnd = false
                    }) {
                        //Start Button Design
                        //HStack - Design Start Button
                        HStack {
                            Image("start")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 50)
                            Text("Start")
                                .fontWeight(.bold)
                                .font(.largeTitle)
                                .minimumScaleFactor(0.7)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(40)
                    }
                    
                    //End Button
                    Button(action: {
                        //Do something here
                        self.setEnd = true
                        self.setStart = false
                    }) {
                        //End Button Design
                        //HStack - Design End Button
                        HStack {
                            Image("end")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 50)
                            Text("End")
                                .fontWeight(.bold)
                                .font(.largeTitle)
                                .minimumScaleFactor(0.7)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.white]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(40)
                    }
                    Spacer()

                }//end of HStack - Start & End Buttons
                
                //HStack - Arrival Time Date-Picker
                /*HStack{
                    Form {
                        DatePicker("Enter an arrival time", selection:
                            self.$wakeUp, in: Date()...)
                    }//.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 70)
                    
                }*/
                
                VStack{
                    Text("Select desired arrival time")
                        .font(.title)
                        .minimumScaleFactor(0.7)
                    
                    DatePicker(selection: self.$selectedDate, in: Date()...) {
                        Text("")
                    }.padding(30)
                    
                    Text("Selected Date is \(self.selectedDate, formatter: self.dateFormatter)")
                        .font(.title)
                        .minimumScaleFactor(0.7)
                }
                
                
                //HStack - Travel Time Label & TextView (updated)
                HStack{
                    Text("Your travel time is: ____________") //Insert variable for travelTime here when done using \(travelTime)
                    
                }
                
                //Set Reminder Button
                
            }//end of VStack - Map and User Area
            
            
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(setStart: true, setEnd: false)
    }
}
