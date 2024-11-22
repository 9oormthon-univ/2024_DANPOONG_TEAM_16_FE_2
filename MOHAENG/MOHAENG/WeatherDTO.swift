//
//  WeatherDTO.swift
//  MOHAENG
//
//  Created by 박동재 on 11/22/24.
//

import Foundation

struct WeatherDTO: Codable {
    
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let daily: [Daily]
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case daily
    }
    
}

struct Daily: Codable {
    
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let summary: String
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let uvi: Double
    let rain: Double?
    let snow: Double?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case summary, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, uvi, rain, snow
    }
    
}

struct Temp: Codable {
    
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
    
}

struct FeelsLike: Codable {
    
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
    
}

struct Weather: Codable {
    
    let id: Int
    let main: String
    let description: String
    let icon: String
    
}
