//
//  Weather.swift
//  Weather
//
//  Created by Renato on 01/03/23.
//

//Model class

import Foundation

public struct Weather {
    let city: String
    let temperature: String
    let description: String
    let iconName: String

    init(response: APIResponse){
        city = response.name
        temperature = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
    } //end innit
} //end public struct Weather
