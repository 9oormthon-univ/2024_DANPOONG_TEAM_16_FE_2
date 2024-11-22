//
//  DetailWeatherView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct DetailWeatherView: View {
    
    private let currentState = "속초"
    
    @State private var dailyList: [Daily] = []
    
    private let tourDays: [Weathers] = [
        Weathers(day: "금", date: "11/22", weather: "Rain", highTemperture: "11", lowTemperture: "2"),
        Weathers(day: "토", date: "11/23", weather: "Rain", highTemperture: "11", lowTemperture: "2"),
        Weathers(day: "일", date: "11/24", weather: "Rain", highTemperture: "11", lowTemperture: "2")
    ]
    
    private let currentStateColor = "#17A1FA"
    private let highTempertureColor = "#FF0000"
    private let lowTempertureColor = "#0095FF"
    
    private let titleFontSize: CGFloat = 20
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("여행기간 중")
                            .font(.system(size: titleFontSize, weight: .semibold))
                        Text(currentState)
                            .font(.system(size: titleFontSize, weight: .semibold))
                            .foregroundColor(Color(hex: "\(currentStateColor)"))
                        Text("날씨")
                            .font(.system(size: titleFontSize, weight: .semibold))
                        
                        Spacer()
                    }
                    
                    HStack {
                        VStack {
                            Spacer()
                            Text("최고")
                                .foregroundColor(Color(hex: "\(highTempertureColor)"))
                            Text("최저")
                                .foregroundColor(Color(hex: "\(lowTempertureColor)"))
                                .padding(.top, 5)
                        }
                        ForEach(tourDays, id: \.self) {day in
                            VStack {
                                Text(day.date)
                                    .font(.system(size: titleFontSize))
                                Image(uiImage: .sunny1)
                                    .padding()
                                Text("\(day.highTemperture)°C")
                                Text("\(day.lowTemperture)°C")
                                    .padding(.top, 5)
                            }
                        }
                    }
                    .padding()
                }
                .padding()
                
                Divider()
                
                VStack {
                    HStack {
                        Text("일주일 날씨")
                            .font(.system(size: titleFontSize, weight: .semibold))
                        
                        Spacer()
                    }
                    
                    VStack {
                        ForEach($dailyList, id: \.self) { day in
                            HStack {
                                let timestamp = Double(day.dt.wrappedValue)
                                let maxTemp = kelvinToCelsius(day.temp.max.wrappedValue)
                                let minTemp = kelvinToCelsius(day.temp.min.wrappedValue)
                                
                                Text(convertUnixTimestampToDate(timestamp))
                                    .padding(.leading)
                                Image(uiImage: weatherImage(for: day.weather[0].main.wrappedValue))
                                    .padding(.leading, 30)
                                
                                Spacer()
                                Spacer()
                                Spacer()
                                
                                Text(String(format: "%.0f°C", maxTemp))
                                Text(String(format: "%.0f°C", minTemp))
                                    .padding(.leading)
                                    .padding(.trailing)
                            }
                            .padding(.top, 25)
                            .padding(.leading)
                            .padding(.trailing)
                        }
                    }
                }
                .padding()
            }
        }
        .scrollIndicators(.hidden)
        .onAppear(perform: {
            setWeather()
        })
    }
}

private extension DetailWeatherView {
    
    func setWeather() {
        MoyaManager.shared.coordinateToList(lat: 37.38911, lon: 128.72995) { result in
            switch result {
            case .success(let data):
                dailyList = data.daily
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }
    
    func convertUnixTimestampToDate(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }

    func kelvinToCelsius(_ kelvin: Double) -> Double {
        return kelvin - 273.15
    }
    
    func weatherImage(for condition: String) -> UIImage {
        switch condition.lowercased() {
        case "clear":
            return .sunny1
        case "cloudy", "clouds":
            return .cloudy
        case "rain":
            return .rainny
        case "snow":
            return .rainny
        default:
            return .sunny1
        }
    }

    
}

#Preview {
    DetailWeatherView()
}
