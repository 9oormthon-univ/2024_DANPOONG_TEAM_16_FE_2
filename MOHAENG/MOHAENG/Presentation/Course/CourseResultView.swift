//
//  CourseResultView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/18/24.
//

import SwiftUI

struct CourseResultView: View {
    
    @State private var draw: Bool = true
    
    var body: some View {
        NavigationStack {
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
