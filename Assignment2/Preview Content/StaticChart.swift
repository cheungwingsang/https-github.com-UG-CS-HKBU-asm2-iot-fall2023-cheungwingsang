//
//  StaticChart.swift
//  Assignment2
//
//  Created by Leo Cheung on 3/11/2023.
//

import SwiftUI
import Charts

struct StaticChart: View {
    
    @State var readings = [Reading]()
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Chart(readings) {
            LineMark(
                x: .value("Time", $0.time),
                y: .value("Humidity", $0.humidity)
            )
        }.padding()
            .onAppear(perform: startLoad)
            .onReceive(timer) { input in
                startLoad()
            }
    }
}

struct Reading: Identifiable {
    let time: Date
    let humidity: Double
    var id: String { time.description }
}

struct EzData: Decodable {
    let status: Int
    let data: String
}
extension StaticChart {
    
    func handleClientError(_: Error) {
        return
    }
    
    func handleServerError(_: URLResponse?) {
        return
    }
    
    func startLoad() {
        
        let url = URL(string: "https://ezdata.m5stack.com/api/store/Dk7ChMFuPDX14Mjnc7LXD93uvyBgXogn/humidity")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                self.handleClientError(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
                return
            }
            
            if let data = data, let ezData = try? JSONDecoder().decode(EzData.self, from: data) {
                
                let reading = Reading(time: Date.now, humidity: Double(ezData.data) ?? 0.0)
                
                if (self.readings.count == 20) {
                    self.readings.removeFirst()
                }
                self.readings.append(reading)
            }
        }
        
        task.resume()
    }
    
}

#Preview {
    StaticChart()
}
