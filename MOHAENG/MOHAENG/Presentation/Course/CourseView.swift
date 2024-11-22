//
//  CourseView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct CourseView: View {
    var body: some View {
        HStack {
            Text("IMG")
                .padding()
            
            VStack(alignment: .leading, content: {
                Text("Title")
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
    CourseResultView(isResultShowing: .constant(true))
}
