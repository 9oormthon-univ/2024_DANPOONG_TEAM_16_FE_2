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
    let day1: [Course]
    let day2: [Course]
    let day3: [Course]
    
}

struct Course: Codable, Hashable {
    
    let name: String
    let address: String
    let imageUrl: String
    
}
