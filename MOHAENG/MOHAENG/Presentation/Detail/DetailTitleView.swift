//
//  DetailTitleView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct DetailTitleView: View {
    
    @Binding var course: CourseDTO
    
    private let titleFontSize: CGFloat = 24
    private let fontSize: CGFloat = 16
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, content: {
                Image(systemName: "figure.stand")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                Text(course.courseName)
                    .font(.system(size: titleFontSize, weight: .semibold))
                HStack {
                    Image(uiImage: .mapPin)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(course.area)
                        .font(.system(size: fontSize))
                }
                HStack {
                    Image(uiImage: .calendar)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("\(course.startDate) - \(course.endDate)")
                            .font(.system(size: fontSize))
                }
                
                DetailNotificationView(list: course.disability)
            })
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
