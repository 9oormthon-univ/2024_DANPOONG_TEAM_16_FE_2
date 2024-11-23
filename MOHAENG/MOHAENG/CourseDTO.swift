//
//  CourseDTO.swift
//  MOHAENG
//
//  Created by 박동재 on 11/23/24.
//

import Foundation

struct CourseDTO: Codable, Hashable {
    
    let courseNumber: Int
    let courseName: String
    let area: String
    let startDate: String
    let endDate: String
    let period: Int
    let disability: [Int]
    var day1: [Course]
    var day2: [Course]
    var day3: [Course]
    
}

struct Course: Codable, Hashable {
    
    var gpsX: Double
    var gpsY: Double
    var contentId: Int
    var contentTypeId: Int
    var name: String
    var address: String
    var imageUrl: String
    
}
