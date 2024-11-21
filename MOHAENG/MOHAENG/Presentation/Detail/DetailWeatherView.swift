//
//  DetailWeatherView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct DetailWeatherView: View {
    
    private let currentState = "속초"
    
    private let tourDays: [Weather] = [
        Weather(day: "금", date: "11/22", weather: "Rain", highTemperture: "11", lowTemperture: "2"),
        Weather(day: "토", date: "11/23", weather: "Rain", highTemperture: "11", lowTemperture: "2"),
        Weather(day: "일", date: "11/24", weather: "Rain", highTemperture: "11", lowTemperture: "2")
    ]
    
    private let weekendWeather: [Weather] = [
        Weather(day: "금", date: "11/22", weather: "Rain", highTemperture: "11", lowTemperture: "2"),
        Weather(day: "토", date: "11/23", weather: "Rain", highTemperture: "11", lowTemperture: "2"),
        Weather(day: "일", date: "11/24", weather: "Rain", highTemperture: "11", lowTemperture: "2"),
        Weather(day: "월", date: "11/25", weather: "Rain", highTemperture: "11", lowTemperture: "2"),
        Weather(day: "화", date: "11/26", weather: "Rain", highTemperture: "11", lowTemperture: "2"),
        Weather(day: "수", date: "11/27", weather: "Rain", highTemperture: "11", lowTemperture: "2"),
        Weather(day: "목", date: "11/28", weather: "Rain", highTemperture: "11", lowTemperture: "2")
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
                        ForEach(weekendWeather, id: \.self) { day in
                            HStack {
                                Text(day.day)
                                    .padding(.leading)
                                Text(day.date)
                                Image(uiImage: .cloudy)
                                    .padding(.leading, 30)
                                
                                Spacer()
                                Spacer()
                                Spacer()
                                
                                Text("\(day.highTemperture)°")
                                Text("\(day.lowTemperture)°")
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
    }
}

#Preview {
    DetailWeatherView()
}
