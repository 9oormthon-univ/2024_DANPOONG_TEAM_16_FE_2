//
//  MOHAENGApp.swift
//  MOHAENG
//
//  Created by 박동재 on 11/18/24.
//

import SwiftUI
import KakaoMapsSDK

@main
struct MOHAENGApp: App {
    
    init() {
        setup()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func setup() {
        guard let KAKAO_API_KEY = Bundle.main.KAKAO_API_KEY else { return }
        SDKInitializer.InitSDK(appKey: KAKAO_API_KEY)
    }
}
