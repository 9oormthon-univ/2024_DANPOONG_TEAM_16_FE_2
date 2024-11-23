//
//  HomeCourseView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/21/24.
//

import SwiftUI

struct HomeCourseView: View {
    
    private var course: CourseListDTO
    
    init(course: CourseListDTO) {
        self.course = course
    }
    
    var body: some View {
        HStack {
            Image(uiImage: .mountain)
                .padding()
            
            VStack(alignment: .leading, content: {
                Text("\(course.courseName)")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                Text("\(course.area)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(hex: "#676767"))
                    .padding(.top, 1)
                Text("\(course.startDate)~\(course.endDate)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            })
            
            Spacer()
            
            Image(systemName: "line.3.horizontal")
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    HomeCourseView(course: CourseListDTO(courseNumber: 1, courseName: "서울 여행 코스", area: "서울", startDate: "2024-12-01", endDate: "2024-12-04"))
}
