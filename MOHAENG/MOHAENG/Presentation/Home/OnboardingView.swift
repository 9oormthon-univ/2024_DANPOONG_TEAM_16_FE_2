//
//  OnboardingView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/21/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var isViewShowing: Bool = false
    
    @Binding var isOnboarding: Bool
    
    var body: some View {
        let url = URL(string: "https://\(Bundle.main.ONBOARDING_URL!)")
        let webView = WebKit(
            request: URLRequest(url: url!), 
            isViewLoading: $isViewShowing,
            isOnboarding: $isOnboarding
        )
        
        VStack {
            webView
                .transaction { transaction in
                    transaction.disablesAnimations = true
                }
                .scrollDisabled(true)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
}
