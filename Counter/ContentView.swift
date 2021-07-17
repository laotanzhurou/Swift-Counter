//
//  ContentView.swift
//  Memorize
//
//  Created by Ke Quan on 11/7/21.
//

import SwiftUI

class Data: ObservableObject {
    @Published var count: Int = 0
}

struct ContentView: View {
    @StateObject var state = Data()
    @State private var timeToNow = 0
    @State private var countUpStarted = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        return ZStack(content:{
            VStack(content: {
                Text(timeToString(time: timeToNow))
                    .padding(20).font(.largeTitle).offset(y:-100)
            
                
                Text("Count now: \(state.count)").padding(20).font(.headline).offset(y:-80)
                
                HStack(content: {
                    Button(action: {
                        state.count = 0
                        timeToNow = 0
                    }) {
                        Text("Reset").padding(20)
                    }
                    
                    Button(action: {
                        countUpStarted = !countUpStarted
                    }) {
                        if !countUpStarted {
                            Text("Start").padding(20)
                        } else {
                            Text("Stop").padding(20)
                        }
                    }
                    
                })
                
                Spacer().frame(height: 50)
                
                Button(action: {
                    state.count += 1
                }){
                    Text("Count")
                        .frame(width: 200, height: 200)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .clipShape(Circle())
                }
                
            }).frame(width: 300, height: 600.0)
        
        }).frame(width: 300, height: 600.0).onReceive(timer, perform: { time in
            if countUpStarted {
                self.timeToNow += 1
            }
        })

    }
}

func timeToString(time: Int) -> String {
    var remaining = time
    let min = remaining / 60
    remaining -= min * 60
    let sec = remaining
    return String(format: "%02d:%02d",
                  min, sec)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
