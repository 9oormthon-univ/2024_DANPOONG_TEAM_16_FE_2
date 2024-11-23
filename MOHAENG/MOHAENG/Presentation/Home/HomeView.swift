//
//  HomeView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/21/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var isOnboarding: Bool = false
    @State var isResultShowing: Bool = false
    @State var isDetailShowing: Bool = false
    
    private let semiboldFontSize: CGFloat = 20
    
    @State private var courseList: [String] = ["1", "2", "3"]
    
    var body: some View {
        VStack {
            Image(uiImage: .title)
            
            ZStack {
                Image(uiImage: .createButton)
                Button {
                    self.isOnboarding.toggle()
                } label: {
                    Text("코스 만들기")
                }
                .buttonStyle(InsetRoundButton())
                .padding(.top, 300)
            }
            
            HStack {
                Text("내 코스 목록")
                    .font(.system(size: semiboldFontSize, weight: .semibold))
                
                Spacer()
            }
            .padding()
            
            if courseList.isEmpty {
                Image(uiImage: .placeholder)
            } else {
                List {
                    ForEach(courseList, id: \.self) { course in
                        Button {
                            //TODO: 코스로 이동
                        } label: {
                            HomeCourseView()
                                .background(.white)
                                .cornerRadius(15)
                                .shadow(radius: 3)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: { indexSet in
                        courseList.remove(atOffsets: indexSet)
                    })
                    .onMove(perform: { indices, newOffset in
                        courseList.move(fromOffsets: indices, toOffset: newOffset)
                    })
                    .onTapGesture {
                        self.isDetailShowing.toggle()
                    }
                }
                .listStyle(PlainListStyle())
                .scrollIndicators(.hidden)
            }
            
            Spacer()
        }
        .fullScreenCover(isPresented: $isOnboarding, content: {
            OnboardingView()
        })
        .fullScreenCover(isPresented: $isResultShowing, content: {
            CourseResultView(isResultShowing: $isResultShowing)
        })
        .fullScreenCover(isPresented: $isDetailShowing, content: {
            DetailResultView(isDetailShowing: $isDetailShowing)
        })
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .onAppear(perform: {
            setCourseList()
        })
    }
}

private extension HomeView {
    
    func setCourseList() {
        MoyaManager.shared.uuidToList(UUID: Bundle.main.UUID) { result in
            switch result {
            case .success(let data):
                dump(data)
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }
    
}

#Preview {
    HomeView()
}
