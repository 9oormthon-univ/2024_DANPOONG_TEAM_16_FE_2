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
    case getCourseList(UUID: String)
    case getCourse(number: Int)
    case getUserExist(UUID: String)
    case postUserRegister(UUID: String)
    
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
        case .getCourseList(let UUID):
            return "api/v1/user/\(UUID)/course"
        case .getCourse(let number):
            return "api/v1/course/search/\(number)"
        case .getUserExist(UUID: _):
            return "api/v1/user/exist"
        case .postUserRegister(UUID: _):
            return "api/v1/user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postUserRegister(UUID: _):
            return .post
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
            
        case let .getUserExist(UUID):
            let params: [String: String] = [
                "uuid": UUID
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case let .postUserRegister(UUID):
            let params: [String: String] = [
                "uuid": UUID
            ]
            
            return .requestJSONEncodable(params)

        default:
            
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
}

