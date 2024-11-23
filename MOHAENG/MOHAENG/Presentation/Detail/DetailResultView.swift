//
//  DetailResultView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct DetailResultView: View {
    
    @State private var course: CourseDTO?
    @Binding var courseNumber: Int?
    
    @State private var draw: Bool = true
    
    @Binding var isDetailShowing: Bool
    
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    init(courseNumber: Binding<Int?>, isDetailShowing: Binding<Bool>) {
        self._courseNumber = courseNumber
        self._isDetailShowing = isDetailShowing
    }
    
    var body: some View {
        ZStack {
            MapView(draw: $draw)
                .onAppear {
                    self.draw = true
                }
                .onDisappear{
                    self.draw = false
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            Button {
                self.isDetailShowing.toggle()
            } label: {
                Image(uiImage: .mountain)
                    .padding(.bottom, 700)
                    .padding(.trailing, 300)
            }
            
            GeometryReader { proxy -> AnyView in
                let height = proxy.frame(in: .global).height - 100
                
                AnyView(
                    DetailBottomSheetView(offset: $offset, course: $course, height: height)
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
        .onAppear(perform: {
            if let number = self.courseNumber {
                setCourse(number: number)
            }
        })
    }
    
}

private extension DetailResultView {
    
    func onBottomSheetChange() {
        Task {
            await MainActor.run {
                self.offset = gestureOffset + lastOffset
            }
        }
    }
    
    func setCourse(number: Int) {
        MoyaManager.shared.idToCourse(number: number) { result in
            switch result {
            case .success(let data):
                self.course = data
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }
 
}
