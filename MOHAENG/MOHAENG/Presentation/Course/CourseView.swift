//
//  CourseView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct CourseView: View {
    
    @Binding var day: Course
    
    init(day: Binding<Course>) {
        self._day = day
    }
    
    var body: some View {
        HStack {
            if let url = URL(string: day.imageUrl) {
                AsyncImage(url: url) { image in
                    image.image?.resizable()
                }
                .frame(maxWidth: 55, maxHeight: 64)
                .cornerRadius(4)
                .background(Color(.white))
                .clipped()
            } else {
                Image(uiImage: .placeholder)
                    .resizable()
                    .cornerRadius(4)
                    .frame(maxWidth: 55, maxHeight: 64)
                    .background(Color(hex: "#F6F5FA"))
                    .clipped()
            }
            
            VStack(alignment: .leading, content: {
                Text("\(day.name)")
                    .font(.system(size: 16, weight: .semibold))
                Text("\(day.address)")
                    .font(.system(size: 12, weight: .medium))
            })
            
            Spacer()
            
            Image(systemName: "line.3.horizontal")
                .foregroundColor(.gray)
        }
        .padding()
    }
    
}
