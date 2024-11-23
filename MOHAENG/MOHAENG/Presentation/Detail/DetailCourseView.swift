//
//  DetailCourseView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct DetailCourseView: View {
    
    @Binding var course: CourseDTO
    @Binding var selectedList: [Course]
    @Binding var selectedNumber: Int
    
    private let backgroundColor = "0A70C9"
    private let defalutColor = "E2E2E2"
    private let fontColor = "FFFFFF"
    
    private let semiboldFontSize: CGFloat = 20
    private let mediumFontSize: CGFloat = 18
    private let floatingFontSize: CGFloat = 16
    
    var body: some View {
        NavigationStack {
            VStack {
                DaysComponent(
                    selectedDay: $selectedNumber,
                    days: course.period,
                    backgroundColor: backgroundColor,
                    defalutColor: defalutColor,
                    fontColor: fontColor
                )
                .padding(.leading, 30)
                .padding(.top, 10)
                
                CourseListView(
                    course: $course,
                    selectedDay: $selectedNumber,
                    dayOneList: $course.day1,
                    dayTwoList: $course.day2,
                    dayThreeList: $course.day3,
                    selectedList: $selectedList,
                    selectedNumber: $selectedNumber
                )
                .padding(.top, 10)
                .padding(.trailing)
                .padding(.leading)
            }
        }
    }
}
