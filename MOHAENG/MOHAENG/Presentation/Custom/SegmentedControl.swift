//
//  SegmentedControl.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct SegmentedControl<Indicator: View>: View {
    
    var tabs: [SegmentedTab]
    @Binding var activeTab: SegmentedTab
    var height: CGFloat = 45
    
    var font: Font = .title3
    var activeTint: Color
    var inactiveTint: Color
    
    @ViewBuilder var indicatorView: (CGSize) -> Indicator
    
    @State private var excessTabWidth: CGFloat = .zero
    @State private var minX: CGFloat = .zero
    
    @available(iOS 17.0, *)
    var body: some View {
        GeometryReader {
            let size = $0.size
            let containerWidthForEachTab = size.width / CGFloat(tabs.count)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.rawValue) { tab in
                    Group {
                        Text(tab.rawValue)
                    }
                    .font(font)
                    .foregroundColor(activeTab == tab ? activeTint : inactiveTint)
                    .animation(.snappy, value: activeTab)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(.rect)
                    .onTapGesture {
                        if let index = tabs.firstIndex(of: tab),
                           let activeIndex = tabs.firstIndex(of: activeTab) {
                            activeTab = tab
                            
                            withAnimation(
                                .snappy(duration: 0.25),
                                completionCriteria: .logicallyComplete) {
                                    excessTabWidth = containerWidthForEachTab * CGFloat(index - activeIndex)
                                } completion: {
                                    withAnimation(.snappy(duration: 0.25)) {
                                        minX = containerWidthForEachTab * CGFloat(index)
                                        excessTabWidth = 0
                                    }
                                }
                        }
                    }
                    .background(alignment: .leading) {
                        if tabs.first == tab {
                            GeometryReader {
                                let size = $0.size
                                
                                indicatorView(size)
                                    .frame(width: size.width + (excessTabWidth < 0 ? -excessTabWidth : excessTabWidth), height: size.height)
                                    .frame(width: size.width, alignment: excessTabWidth < 0 ? .trailing : .leading)
                                    .offset(x: minX)
                            }
                        }
                    }
                }
            }
        }
        .frame(height: height)
    }
    
}
