//
//  HomeCourseView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/21/24.
//

import SwiftUI

struct HomeCourseView: View {
    var body: some View {
        HStack {
            Text("IMG")
                .padding()
            
            VStack(alignment: .leading, content: {
                Text("Title")
                Text("Address")
                Text("Address")
            })
            
            Spacer()
            
            Image(systemName: "line.3.horizontal")
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    HomeCourseView()
}
