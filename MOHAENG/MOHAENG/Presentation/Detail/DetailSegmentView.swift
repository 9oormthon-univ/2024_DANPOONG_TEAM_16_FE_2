//
//  DetailSegmentView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct DetailSegmentView: View {
    
    @State private var activeTab: SegmentedTab = .course
    
    var body: some View {
        NavigationStack {
            DetailTitleView()
                .padding(.top, 50)
            
            VStack(spacing: 15) {
                SegmentedControl(
                    tabs: SegmentedTab.allCases,
                    activeTab: $activeTab,
                    height: 35,
                    font: .body,
                    activeTint: .black,
                    inactiveTint: .gray.opacity(0.7)
                ) {
                    size in
                    Rectangle()
                        .fill(.black)
                        .frame(height: 2)
                        .padding(.horizontal, 10)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
                
            }
            
            if activeTab == .course {
                DetailCourseView()
            } else if activeTab == .weather {
                DetailWeatherView()
            }
            
            Spacer()
        }
    }
}

enum SegmentedTab: String, CaseIterable {
    
    case course = "여행 코스"
    case weather = "날씨"
    
}

#Preview {
    DetailResultView()
}
