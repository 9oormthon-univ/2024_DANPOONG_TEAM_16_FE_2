//
//  CourseResultView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/18/24.
//

import SwiftUI

struct CourseResultView: View {
    
    @State private var draw: Bool = true
    
    private let place = "속초"
    private let period = "2박3일"
    private let mention = "더욱 쉽게 접근할 수 있는 코스로 준비했어요"
    
    private let semiboldFontSize: CGFloat = 20
    private let mediumFontSize: CGFloat = 18
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: .mountain)
                HStack {
                    Text(place)
                        .font(.system(size: semiboldFontSize, weight: .semibold))
                    Text(period)
                        .font(.system(size: semiboldFontSize, weight: .semibold))
                }
                .padding(3)
                Text(mention)
                    .font(.system(size: mediumFontSize, weight: .medium))
                    .padding(3)
                
                GeometryReader { geometry in
                    MapView(draw: $draw)
                        .onAppear {
                            self.draw = true
                        }
                        .onDisappear{
                            self.draw = false
                        }
                        .frame(height: geometry.size.height * 0.3)
                }
            }
        }
    }
    
}

#Preview {
    CourseResultView()
}
