//
//  CourseSaveView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/22/24.
//

import SwiftUI

struct CourseSaveView: View {
    
    @Binding var isSaving: Bool
    
    @State var text: String = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            ZStack {
                HStack {
                    Button {
                        self.isSaving.toggle()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(.label))
                    }
                    Spacer()
                }
                .padding()
                
                Text("내 코스로 등록하기")
                    .font(.system(size: 20, weight: .semibold))
            }
            
            VStack {
                HStack {
                    Text("코스 제목 입력")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                }
                TextField("코스의 제목을 만들어주세요. (ex) 가족여행)", text: self.$text)
                    .autocorrectionDisabled()
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                    .padding(.horizontal, 15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color(hex: "#F2F2F2"))
                    )
                
                Spacer()
                
                HStack {
                    Text("여행 시작일을 선택해주세요")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                }
                
                DatePicker("Date", selection: $date, displayedComponents: [.date])
                    .datePickerStyle(.wheel)
                    .padding()
                    .labelsHidden()
                
                Spacer()
                Spacer()
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("저장")
                            .frame(maxWidth: .infinity, maxHeight: 55)
                            .foregroundColor(Color(.white))
                            .font(.system(size: 20, weight: .bold))
                    }
                    .buttonStyle(.plain)
                    .background(text == "" ? Color(hex: "#D9D9D9") : Color(hex: "#1650A9"))
                    .cornerRadius(10)
                    .disabled(text.isEmpty)
                }

            }
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    CourseSaveView(isSaving: .constant(true))
}
