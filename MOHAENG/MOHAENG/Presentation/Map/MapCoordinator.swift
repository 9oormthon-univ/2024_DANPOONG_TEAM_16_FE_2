//
//  MapCoordinator.swift
//  MOHAENG
//
//  Created by 박동재 on 11/18/24.
//

import Foundation
import KakaoMapsSDK

final class KakaoMapCoordinator: NSObject, MapControllerDelegate {
    
    var controller: KMController?
    var first: Bool = true
    
    var userMapPoint: MapPoint? = MapPoint(longitude: 127.10, latitude: 37.34)
    
    override init() {
        super.init()
    }
    
    func createController(_ view: KMViewContainer) {
        controller = KMController(viewContainer: view)
        controller?.delegate = self
    }
    
    func addViews() {
        let mapviewInfo: MapviewInfo = MapviewInfo(
            viewName: "mapview",
            viewInfoName: "map",
            defaultPosition: self.userMapPoint,
            defaultLevel: 10
        )
        
        guard let controller else { return }

        controller.addView(mapviewInfo)
    }
    
    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        guard let mapView = controller?.getView(viewName) as? KakaoMap else { return }
    }
    
    func addViewFailed(_ viewName: String, viewInfoName: String) {
        
    }
    
    func containerDidResized(_ size: CGSize) {
        let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
        mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
        if first,
           let userMapPoint = userMapPoint {
            let cameraUpdate: CameraUpdate = CameraUpdate.make(
                target: userMapPoint,
                zoomLevel: 10, mapView: mapView!
            )
            mapView?.moveCamera(cameraUpdate)
            first = false
        }
    }
    
}
