//
//  NetworkManager.swift
//  MOHAENG
//
//  Created by 박동재 on 11/21/24.
//

import Foundation
import Moya

enum NetworkManager {
    
}

extension NetworkManager: TargetType {
    var baseURL: URL {
        return URL(string: "\(String(describing: Bundle.main.BASE_URL))")!
    }
    
    var path: String {
        switch self {
            
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
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
}

