//
//  DetailCourseView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct DetailCourseView: View {
    
    @State var selectedDay: Int = 0
    
    private let daysList: [String] = ["1일차", "2일차", "3일차"]
    
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
                    selectedDay: $selectedDay,
                    daysList: daysList,
                    backgroundColor: backgroundColor,
                    defalutColor: defalutColor,
                    fontColor: fontColor
                )
                .padding(.leading, 30)
                .padding(.top, 10)
                
                CourseListView()
            }
        }
    }
}

#Preview {
    DetailCourseView()
}
