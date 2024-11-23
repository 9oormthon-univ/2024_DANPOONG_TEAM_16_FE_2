//
//  DetailBottomSheetView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct DetailBottomSheetView: View {
    
    @Binding var offset: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            DetailSegmentView()
                .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
            
            VStack {
                VStack {
                    Capsule()
                        .fill(Color.black)
                        .frame(width: 120, height: 4)
                }
                .frame(height: 40)
            }
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
}
