//
//  CourseResultView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/18/24.
//

import SwiftUI

struct CourseResultView: View {
    
    @State private var dayList: [[Course]] = [[]]
    
    @State private var draw: Bool = true
    @State private var isSaving: Bool = false
    @State var selectedDay: Int = 0
    
    @State var selectedList: [Course] = []
    @State var selectedNumber: Int = 1
    
    @Binding var isResultShowing: Bool
    @Binding var courseNumber: Int
    
    @State var course: CourseDTO = CourseDTO(courseNumber: 1, courseName: "1", area: "서울", startDate: "2024/11/23", endDate: "2024/11/24", period: 2, disability: [], gpsX: 38.4, gpsY: 123.4, day1: [], day2: [], day3: [])
    
    private let mention = "더욱 쉽게 접근할 수 있는 코스로 준비했어요"
    
    private let backgroundColor = "0A70C9"
    private let defalutColor = "E2E2E2"
    private let fontColor = "FFFFFF"
    
    private let semiboldFontSize: CGFloat = 20
    private let mediumFontSize: CGFloat = 18
    private let floatingFontSize: CGFloat = 16
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        ZStack {
                            HStack {
                                Button {
                                    self.isResultShowing.toggle()
                                } label: {
                                    Image(uiImage: .back)
                                }
                                Spacer()
                            }
                            .padding()
                            
                            Text("완성된 코스를 확인해보세요")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        
//                        Image(uiImage: .mountain)
                        HStack {
                            Text(course.area)
                                .font(.system(size: semiboldFontSize, weight: .semibold))
                            Text("\(course.period)박 \(course.period + 1)일")
                                .font(.system(size: semiboldFontSize, weight: .semibold))
                        }
                        .padding(3)
                        Text(mention)
                            .font(.system(size: mediumFontSize, weight: .medium))
                            .padding(3)
                        
                        MapView(
                            draw: $draw,
                            gpsY: $course.gpsY,
                            gpsX: $course.gpsX,
                            list: $dayList[0]
                        )
                        .onAppear {
                            self.draw = true
                        }
                        .onDisappear{
                            self.draw = false
                        }
                        .frame(height: geometry.size.height * 0.3)
                        
                        DaysComponent(
                            selectedDay: $selectedDay,
                            days: course.period,
                            backgroundColor: backgroundColor,
                            defalutColor: defalutColor,
                            fontColor: fontColor
                        )
                        .padding(.leading, 30)
                        .padding(.top, 10)
                        
                        CourseListView(
                            course: $course,
                            selectedDay: $selectedNumber,
                            dayOneList: $course.day1,
                            dayTwoList: $course.day2,
                            dayThreeList: $course.day3,
                            selectedList: $selectedList,
                            selectedNumber: $selectedNumber
                        )
                    }
                    
                    Button {
                        self.isSaving.toggle()
                    } label: {
                        Text("내 코스로 등록하기")
                            .font(.system(size: floatingFontSize, weight: .semibold))
                    }
                    .buttonStyle(InsetRoundButton())
                    .padding(.top, geometry.size.height * 0.5)
                    
                }
            }
        }
        .fullScreenCover(isPresented: $isSaving, content: {
            CourseSaveView(isSaving: $isSaving)
        })
        .onAppear {
            setResult()
        }
    }
}

private extension CourseResultView {
    
    func setResult() {
//        MoyaManager.shared.idToCourse(number: self.courseNumber) { result in
        MoyaManager.shared.idToCourse(number: 25) { result in
            switch result {
            case .success(let data):
                self.course = data
                self.selectedDay = 1
                self.selectedList = data.day1
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }
    
}
