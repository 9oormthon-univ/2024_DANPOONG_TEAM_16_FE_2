//
//  DetailResultView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct DetailResultView: View {
    
    @State private var draw: Bool = true
    
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            MapView(draw: $draw)
                .onAppear {
                    self.draw = true
                }
                .onDisappear{
                    self.draw = false
                }
                .frame(width: .infinity, height: .infinity)
                .ignoresSafeArea()
            
            GeometryReader { proxy -> AnyView in
                let height = proxy.frame(in: .global).height - 100
                
                AnyView(
                    DetailBottomSheetView(offset: $offset, height: height)
                        .offset(y: height)
                        .offset(y: -offset > 0 ? -offset <= height ? offset : -height : 0)
                        .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                            out = value.translation.height
                            onBottomSheetChange()
                        }).onEnded({ value in
                            withAnimation {
                                if -offset < height / 2 {
                                    offset = -(height / 3)
                                } else {
                                    offset = -height
                                }
                            }
                            lastOffset = offset
                        }))
                        .edgesIgnoringSafeArea(.bottom)
                        .onAppear {
                            self.offset = -(height / 3)
                            lastOffset = offset
                        }
                )
            }
        }
    }
    
}

extension DetailResultView {
    
    private func onBottomSheetChange() {
        Task {
            await MainActor.run {
                self.offset = gestureOffset + lastOffset
            }
        }
    }
 
}

#Preview {
    DetailResultView()
}
