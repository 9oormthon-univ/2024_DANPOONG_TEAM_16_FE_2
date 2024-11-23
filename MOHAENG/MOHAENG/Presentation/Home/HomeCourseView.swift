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
            if let url = URL(string: course.originalImage) {
                AsyncImage(url: url) { image in
                    image.image?.resizable()
                }
                .frame(maxWidth: 70, maxHeight: 80)
                .cornerRadius(4)
                .background(Color(.white))
                .clipped()
            } else {
                Image(uiImage: .placeholder)
                    .resizable()
                    .cornerRadius(4)
                    .frame(maxWidth: 70, maxHeight: 80)
                    .background(Color(hex: "#F6F5FA"))
                    .clipped()
            }
            
            VStack(alignment: .leading, content: {
                Text("\(course.courseName)")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                Text("\(course.area)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(hex: "#676767"))
                    .padding(.top, 1)
                HStack {
                    Text("\(course.startDate)~\(course.endDate)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black)
                    Text("[\(course.period)박\(course.period + 1)일]")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black)
                }
            })
            .padding(.leading, 10)
            
            Spacer()
            
            Image(systemName: "line.3.horizontal")
                .foregroundColor(.gray)
        }
        .padding()
    }
}
