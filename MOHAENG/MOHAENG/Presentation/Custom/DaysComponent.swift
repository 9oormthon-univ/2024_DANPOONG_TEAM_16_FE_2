//
//  DaysComponent.swift
//  MOHAENG
//
//  Created by 박동재 on 11/18/24.
//

import SwiftUI

struct DaysComponent: View {
    
    @Binding var selectedDay: Int
    let daysList: [String]
    let backgroundColor: String
    let defalutColor: String
    let fontColor: String
        
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<daysList.count, id: \.self) { index in
                    Button {
                        self.selectedDay = index
                    } label: {
                        Text("\(self.daysList[index])")
                            .font(.system(size: 14))
                            .foregroundStyle(Color(hex: "\(fontColor)"))
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    }
                    .background(self.selectedDay == index ? Color(hex: "\(backgroundColor)") : Color(hex: "\(defalutColor)"))
                    .cornerRadius(100)
                    .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2))
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
    }

}
