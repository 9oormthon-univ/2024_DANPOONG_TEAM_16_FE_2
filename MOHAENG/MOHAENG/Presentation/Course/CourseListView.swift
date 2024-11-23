//
//  CourseListView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct CourseListView: View {
    
    @Binding var course: CourseDTO
    @Binding var selectedDay: Int
    
    @Binding var dayOneList: [Course]
    @Binding var dayTwoList: [Course]
    @Binding var dayThreeList: [Course]
    
    @State private var selectedList: [Course] = []
    
    @State private var numbers: [Course] = [
        Course(name: "1", address: "2", imageUrl: "3"),
        Course(name: "4", address: "5", imageUrl: "6")
    ]
    @State private var isWebViewShowing: Bool = false
    
    init(
        course: Binding<CourseDTO>,
        selectedDay: Binding<Int>,
        dayOneList: Binding<[Course]>,
        dayTwoList: Binding<[Course]>,
        dayThreeList: Binding<[Course]>
    ) {
        self._course = course
        self._selectedDay = selectedDay
        self._dayOneList = dayOneList
        self._dayTwoList = dayTwoList
        self._dayThreeList = dayThreeList
    }
    
    var body: some View {
        
        ForEach($selectedList, id: \.self) { day in
            HStack {
                VStack {
                    ZStack(alignment: .center) {
                        Image(uiImage: .placeMarker)
                            .resizable()
                            .scaledToFit()
                        Text(" ")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .padding(.bottom, 3)
                    }
                    .frame(height: 28)
                    
                    Image(uiImage: .dotLine)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                }
                CourseView(day: day)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 0.2)
                            .foregroundColor(.gray)
                    )
            }
            .listRowSeparator(.hidden)
        }
        .onDelete(perform: { indexSet in
            numbers.remove(atOffsets: indexSet)
        })
        .onMove(perform: { indices, newOffset in
            numbers.move(fromOffsets: indices, toOffset: newOffset)
        })
        .onTapGesture {
            self.isWebViewShowing.toggle()
        }
        .onChange(of: selectedDay) { _, newValue in
            dump(course)
            if newValue == 1 {
                selectedList = dayOneList
            } else if newValue == 2 {
                selectedList = dayTwoList
            } else if newValue == 3 {
                selectedList = dayThreeList
            }
        }
        .fullScreenCover(isPresented: $isWebViewShowing, content: {
            CourseWebView()
        })
    }

}

