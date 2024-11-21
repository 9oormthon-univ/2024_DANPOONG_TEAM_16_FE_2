//
//  Bundle+.swift
//  MOHAENG
//
//  Created by 박동재 on 11/18/24.
//

import Foundation

extension Bundle {
    
    var KAKAO_API_KEY: String? {
        return infoDictionary?["KAKAO_API_KEY"] as? String
    }
    
    var WEATHER_KEY: String? {
        return infoDictionary?["WEATHER_KEY"] as? String
    }
    
    var BASE_URL: String? {
        return infoDictionary?["BASE_URL"] as? String
    }
    
}
