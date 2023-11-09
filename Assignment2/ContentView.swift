//
//  ContentView.swift
//  Assignment2
//
//  Created by Leo Cheung on 3/11/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    var body: some View {
        TabView {
            StaticChart().tabItem {
                Image(systemName: "waveform.circle.fill")
                Text("Static")
            }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
            
        }
    }
}
