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
    
    func uuidToList(UUID: String, completion: @escaping (Result<[CourseListDTO], Error>) -> Void) {
        provider.request(.getCourseList(UUID: UUID)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([CourseListDTO].self, from: response.data)
                    
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func idToCourse(number: Int, completion: @escaping (Result<[CourseListDTO], Error>) -> Void) {
        provider.request(.getCourse(number: number)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([CourseListDTO].self, from: response.data)
                    
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
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
    
    func checkUUID(UUID: String, completion: @escaping (Result<String, Error>) -> Void) {
        provider.request(.getUserExist(UUID: UUID)) { result in
            switch result {
            case .success(let response):
                if let data = String(data: response.data, encoding: .utf8) {
                        completion(.success(data))
                } else {
                    completion(.failure(NSError(domain: "DataDecodingError", code: 0)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func registerUUID(UUID: String, completion: @escaping (Result<String, Error>) -> Void) {
        provider.request(.postUserRegister(UUID: UUID)) { result in
            switch result {
            case .success(let response):
                if let data = String(data: response.data, encoding: .utf8) {
                        completion(.success(data))
                } else {
                    completion(.failure(NSError(domain: "DataDecodingError", code: 0)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
