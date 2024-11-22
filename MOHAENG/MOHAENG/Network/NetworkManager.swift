//
//  NetworkManager.swift
//  MOHAENG
//
//  Created by 박동재 on 11/21/24.
//

import Foundation
import Moya

enum NetworkManager {
    
    case getWeather(lat: Double, lon: Double)
    
}

extension NetworkManager: TargetType {
    var baseURL: URL {
        switch self {
        case .getWeather:
            let urlString: String = Bundle.main.WEATHER_URL!
            return URL(string: "https://\(urlString)")!
        default:
            let urlString: String = Bundle.main.BASE_URL!
            return URL(string: "http://\(urlString)")!
        }
    }
    
    var path: String {
        switch self {
        case .getWeather(lat: _, lon: _):
            return "onecall"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .getWeather(lat, lon):
            let params: [String: Any] = [
                "lat": lat,
                "lon": lon,
                "appid": Bundle.main.WEATHER_KEY!,
                "exclude": "current,minutely,hourly"
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
}

