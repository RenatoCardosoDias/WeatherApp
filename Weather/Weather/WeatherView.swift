//
//  ContentView.swift
//  Weather
//
//  Created by Renato on 28/02/23.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack {
            Text("Los Angeles")
                .font(.largeTitle)
                .padding()
            Text("25ºC")
                .font(.system(size: 70))
                .bold()
            Text("🌥️")
                .font(.largeTitle)
                .padding()
            Text("Clear Sky")
                .font(.largeTitle)
        } //end VStack
    } //end var body
} //end struct

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
