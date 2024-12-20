//
//  CourseResultView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/18/24.
//

import SwiftUI

struct CourseResultView: View {
    
    @State private var draw: Bool = true
    @State private var isSaving: Bool = false
    @State var selectedDay: Int = 0
    
    @Binding var isResultShowing: Bool
    
    private let place = "속초"
    private let period = "2박3일"
    private let mention = "더욱 쉽게 접근할 수 있는 코스로 준비했어요"
    
    private let daysList: [String] = ["1일차", "2일차", "3일차"]
    
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
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(Color(.label))
                                }
                                Spacer()
                            }
                            .padding()
                            
                            Text("완성된 코스를 확인해보세요")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        
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
                        
                        MapView(draw: $draw)
                            .onAppear {
                                self.draw = true
                            }
                            .onDisappear{
                                self.draw = false
                            }
                            .frame(height: geometry.size.height * 0.3)
                        
                        DaysComponent(
                            selectedDay: $selectedDay,
                            daysList: daysList,
                            backgroundColor: backgroundColor,
                            defalutColor: defalutColor,
                            fontColor: fontColor
                        )
                        .padding(.leading, 30)
                        .padding(.top, 10)
                        
                        CourseListView()
                    }
                    
                    Button {
                        self.isSaving.toggle()
                    } label: {
                        Text("내 코스로 등록하기")
                            .font(.system(size: floatingFontSize, weight: .semibold))
                    }
                    .buttonStyle(InsetRoundButton())
                    .padding(.top, geometry.size.height * 0.8)

                }
            }
        }
        .fullScreenCover(isPresented: $isSaving, content: {
            CourseSaveView(isSaving: $isSaving)
        })
    }
}

#Preview {
    CourseResultView(isResultShowing: .constant(true))
}
