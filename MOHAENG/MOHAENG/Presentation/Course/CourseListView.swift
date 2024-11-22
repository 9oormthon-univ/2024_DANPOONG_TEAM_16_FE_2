//
//  CourseListView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/19/24.
//

import SwiftUI

struct CourseListView: View {
    
    @State private var numbers: [Int] = [ 1, 2, 3, 4, 5 ]
    @State private var isWebViewShowing: Bool = false
    
    var body: some View {
        List {
            ForEach(numbers, id: \.self) { index in
                HStack {
                    VStack {
                        ZStack(alignment: .center) {
                            Image(uiImage: .placeMarker)
                                .resizable()
                                .scaledToFit()
                            Text("\(index)")
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
                    CourseView()
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
        }
        .listStyle(PlainListStyle())
        .scrollIndicators(.hidden)
        .fullScreenCover(isPresented: $isWebViewShowing, content: {
            CourseWebView()
        })
    }
}

#Preview {
    CourseResultView()
}
