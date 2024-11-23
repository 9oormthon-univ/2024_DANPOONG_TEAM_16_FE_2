//
//  DetailTitleView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct DetailTitleView: View {
    
    private let title = "단풍톤 워크샵"
    private let place = "카카오 AI 캠퍼스"
    private let start = "2024/11/23"
    private let end = "2024/11/25"
    
    private let titleFontSize: CGFloat = 24
    private let fontSize: CGFloat = 16
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, content: {
                Image(systemName: "figure.stand")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                Text(title)
                    .font(.system(size: titleFontSize, weight: .semibold))
                HStack {
                    Image(uiImage: .mapPin)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(place)
                        .font(.system(size: fontSize))
                }
                HStack {
                    Image(uiImage: .calendar)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("\(start) - \(end)")
                            .font(.system(size: fontSize))
                }
                
                DetailNotificationView(list: ["- 고령자를 위한 이동 편의"])
            })
            .frame(width: .infinity)
            
            Spacer()
        }
        .frame(width: .infinity)
        .padding()
    }
}
