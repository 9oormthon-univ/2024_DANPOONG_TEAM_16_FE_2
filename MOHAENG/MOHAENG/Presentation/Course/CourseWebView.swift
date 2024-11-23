//
//  CourseWebView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/23/24.
//

import SwiftUI

struct CourseWebView: View {
    
    @State var isViewLoading: Bool = false
    @Binding var isOnboarding: Bool

    var body: some View {
        let url = URL(string: "https://\(Bundle.main.DETAIL_URL!)")
        let webView = WebKit(
            request: URLRequest(url: url!),
            isViewLoading: $isViewLoading,
            isOnboarding: $isOnboarding
        )
        
        VStack {
            webView
                .transaction { transaction in
                    transaction.disablesAnimations = true
                }
                .scrollDisabled(true)
                .task {
                    webView.sendContentID(contentID: 125266)
                }
                .edgesIgnoringSafeArea(.all)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}
