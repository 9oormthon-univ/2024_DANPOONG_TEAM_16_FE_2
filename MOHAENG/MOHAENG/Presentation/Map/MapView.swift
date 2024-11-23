//
//  MapView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/18/24.
//

import SwiftUI
import KakaoMapsSDK

struct MapView: UIViewRepresentable {
    
    @Binding var draw: Bool
    @Binding var gpsY: Double?
    @Binding var gpsX: Double?
    @Binding var list: [Course]
    
    func makeUIView(context: Self.Context) -> KMViewContainer {
        let view: KMViewContainer = KMViewContainer()
        view.sizeToFit()
        context.coordinator.createController(view)
        context.coordinator.controller?.prepareEngine()
        
        return view
    }
    
    func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
        if draw {
            Task {
                try? await Task.sleep(for: .seconds(0.5))
                context.coordinator.controller?.activateEngine()
                context.coordinator.controller?.prepareEngine()
                
                context.coordinator.updatePois(placeList: list, gpsY: gpsY, gpsX: gpsX)
                context.coordinator.updateRouteLine()
            }
        } else {
            context.coordinator.controller?.resetEngine()
        }
    }
    
    func makeCoordinator() -> KakaoMapCoordinator {
        return KakaoMapCoordinator()
    }
    
    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        
    }
    
}

