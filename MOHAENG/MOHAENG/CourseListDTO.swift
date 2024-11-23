//
//  CourseListDTO.swift
//  MOHAENG
//
//  Created by 박동재 on 11/23/24.
//

import Foundation

struct CourseListDTO: Codable {
    
    let courseNumber: Int
    let courseName: String
    let area: String
    let startDate: String
    let endDate: String
    
}
