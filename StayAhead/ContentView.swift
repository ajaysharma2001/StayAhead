//
//  ContentView.swift
//  StayAhead
//
//  Created by Ajay Sharma on 2019-12-17.
//  Copyright © 2019 MrGoose. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                MapView()
                
                HStack {
                    Text("Start")
                    Text("End")
                    Text("Arrival Time")
                }
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
