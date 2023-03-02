//
//  ContentView.swift
//  Weather
//
//  Created by Renato on 28/02/23.
//

import SwiftUI

struct WeatherView: View {

    //nos estamos observando as propriedades da WeatherViewModel

    @ObservedObject var viewModel: WeatherViewModel //através desta prorpriedade (view model) nos vamos obter as informações que precisamos para mostrar em nossos textos


    var body: some View {
        VStack {
            Text(viewModel.cityName)
                .font(.largeTitle)
                .padding()
            Text(viewModel.temperature)
                .font(.system(size: 70))
                .bold()
            Text(viewModel.weatherIcon)
                .font(.largeTitle)
                .padding()
            Text(viewModel.weatherDescription)
                .font(.largeTitle)
        } //end VStack
        //agora queremos garantir que os dados serão atualizados quando a nossa view aparecer
        .onAppear(perform: viewModel.refresh)
    } //end var body
} //end struct

//agora temos WeatherviewModel como parte de nossa WeatherView, entao agora precisamos atualizar cada lugar onde estamos criando uma visualização da WeatherView para fornecer uma WeatherViewModel, entao vamos atualizar a prévisualização

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
