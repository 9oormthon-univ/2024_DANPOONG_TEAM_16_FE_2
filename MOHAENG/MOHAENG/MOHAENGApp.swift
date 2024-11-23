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
    
    @State private var isCheck: Bool = false
    
    init() {
        setup()
    }
    
    var body: some Scene {
        WindowGroup {
            if !isCheck {
                VStack {
                    Image(uiImage: .splash)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                }
                .onAppear(perform: {
                    checkUUID()
                })
            } else {
                HomeView()
            }
        }
    }
    
    private func setup() {
        guard let KAKAO_API_KEY = Bundle.main.KAKAO_API_KEY else { return }
        SDKInitializer.InitSDK(appKey: KAKAO_API_KEY)
    }
    
    private func checkUUID() {
        MoyaManager.shared.checkUUID(UUID: Bundle.main.UUID) { result in
            switch result {
            case .success(let response):
                if response == "유저가 존재하지 않습니다\n" {
                    registerUUID()
                } else {
                    self.isCheck = true
                }
            case .failure(let error):
                dump(error.localizedDescription)
            }

        }
    }
    
    private func registerUUID() {
        MoyaManager.shared.registerUUID(UUID: Bundle.main.UUID) { result in
            switch result {
            case .success(_):
                self.isCheck = true
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }
    
}
