//
//  CourseWebView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/23/24.
//

import SwiftUI

struct CourseWebView: View {
    
    @State var isViewLoading: Bool = false

    var body: some View {
        let url = URL(string: "https://\(Bundle.main.DETAIL_URL!)")
        let webView = WebKit(
            request: URLRequest(url: url!),
            isViewLoading: $isViewLoading,
            isOnboarding: $isViewLoading
        )
        
        VStack {
            webView
                .transaction { transaction in
                    transaction.disablesAnimations = true
                }
                .scrollDisabled(true)
                .task {
                    webView.sendContentID(contentID: 123)
                }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
}

#Preview {
    CourseWebView()
}
