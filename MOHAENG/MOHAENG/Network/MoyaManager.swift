//
//  MoyaManager.swift
//  MOHAENG
//
//  Created by 박동재 on 11/21/24.
//

import Foundation
import Moya

final class MoyaManager {
    
    static let shared = MoyaManager()
    let provider: MoyaProvider = MoyaProvider<NetworkManager>()
    
    func coordinateToList(lat: Double, lon: Double, completion: @escaping (Result<WeatherDTO, Error>) -> Void) {
        provider.request(.getWeather(lat: lat, lon: lon)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(WeatherDTO.self, from: response.data)
                    
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
