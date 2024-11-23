//
//  DetailNotificationView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/20/24.
//

import SwiftUI

struct DetailNotificationView: View {
    
    private var list: [String] = []
    
    private let notificationFontColor = "184EA7"
    private let notificationBackgroundColor = "E4F8FF"
    
    private let fontSize: CGFloat = 14
    
    init(list: [String]) {
        self.list = list
    }
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("💡 다음을 고려했어요")
                    .font(.system(size: fontSize, weight: .semibold))
                    .foregroundColor(Color(hex: "\(notificationFontColor)"))
                    .padding(.bottom, 5)
                
                ForEach(list, id: \.self) { component in
                    Text("\(component)")
                        .font(.system(size: fontSize, weight: .semibold))
                }
            }
            .padding()
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex: "\(notificationBackgroundColor)"))
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
