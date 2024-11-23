//
//  DetailResultView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct DetailResultView: View {
    
    @State private var course: CourseDTO = CourseDTO(courseNumber: 1, courseName: "1", area: "서울", startDate: "2024/11/23", endDate: "2024/11/24", period: 2, disability: [], gpsX: 38.4, gpsY: 123.4, day1: [], day2: [], day3: [])
    @State private var selectedList: [Course] = []
    @State private var selectedNumber: Int = 1
    
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
            MapView(
                draw: $draw,
                gpsY: $course.gpsY,
                gpsX: $course.gpsX,
                list: $selectedList
            )
            .onAppear {
                self.draw = true
            }
            .onDisappear{
                self.draw = false
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        self.isDetailShowing.toggle()
                    } label: {
                        Image(uiImage: .back)
                            .frame(width: 44, height: 44) 
                            .contentShape(Rectangle())
                    }
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    
                    Spacer()
                }
                Spacer()
            }
            
            GeometryReader { proxy -> AnyView in
                let height = proxy.frame(in: .global).height - 100
                
                AnyView(
                    DetailBottomSheetView(
                        offset: $offset, 
                        course: $course,
                        selectedList: $selectedList,
                        selectedNumber: $selectedNumber,
                        height: height
                    )
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
        .onChange(of: self.selectedList) { oldValue, newValue in
            dump(newValue)
        }
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
                self.selectedList = data.day1
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }
 
}
