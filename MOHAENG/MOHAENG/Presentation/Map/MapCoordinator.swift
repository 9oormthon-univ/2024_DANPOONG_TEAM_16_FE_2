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
    var placeList: [Course] = []
    
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
        
        createLabelLayer()
        createPoiStyle()
        
        createRouteLayer()
        createRouteStyleSet()
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

//MARK: Poi
extension KakaoMapCoordinator {
    
    func createLabelLayer() {
        guard let controller else { return }
        guard let view = controller.getView("mapview") as? KakaoMap else { return }
        
        let manager = view.getLabelManager()
        let layerOption = LabelLayerOptions(
            layerID: "PoiLayer",
            competitionType: .none,
            competitionUnit: .symbolFirst,
            orderType: .rank,
            zOrder: 0
        )
        let _ = manager.addLabelLayer(option: layerOption)
    }
    
    func createPoiStyle() {
        guard let view = controller?.getView("mapview") as? KakaoMap else { return }
        let manager = view.getLabelManager()
        
        let defaultIconStyle = PoiIconStyle(symbol: UIImage(named: "PlaceMarker"))
        let defaultPoiStyle = PoiStyle(styleID: "defaultStyle", styles: [PerLevelPoiStyle(iconStyle: defaultIconStyle, level: 0)])
        
//        let userIconStyle = PoiIconStyle(symbol: UIImage(named: "userLocation"))
//        let userPoiStyle = PoiStyle(styleID: "userStyle", styles: [PerLevelPoiStyle(iconStyle: userIconStyle, level: 0)])
        
//        manager.addPoiStyle(userPoiStyle)
        manager.addPoiStyle(defaultPoiStyle)
    }
    
    func updatePois(placeList: [Course], gpsY: Double?, gpsX: Double?) {
        
        guard let view = controller?.getView("mapview") as? KakaoMap else { return }
        guard let gpsY = gpsY else { return }
        guard let gpsX = gpsX else { return }
        
        self.placeList = placeList
        self.userMapPoint = MapPoint(longitude: gpsX, latitude: gpsY)
        
        let manager = view.getLabelManager()
        let layer = manager.getLabelLayer(layerID: "PoiLayer")
        
        let guiManager = view.getGuiManager()
        guiManager.infoWindowLayer.clear()
        
        let pois = layer?.getAllPois().map { $0.map { return $0.itemID } } ?? []
        layer?.removePois(poiIDs: pois)
        
        let poiList = placeList.map {
            return MapPoint(longitude: $0.gpsX, latitude: $0.gpsY)
        }
        
        let poiOptions = placeList.map { list in
            let poiOption = PoiOptions(styleID: "defaultStyle", poiID: String(list.name))
            poiOption.rank = 0
            poiOption.clickable = true
            return poiOption
        }
        
        _ = placeList.map { list in
            Task {
//                guard let url = URL(string: list.imageURL) else { return }
//                let (data, response) = try await URLSession.shared.data(from: url)
                
                let placeIconStyle = PoiIconStyle(symbol: UIImage(named: "PlaceMarker"))
//                let pokemonIconStyle = PoiIconStyle(symbol: UIImage(data: data))
                
                let placePoiStyle = PoiStyle(
                    styleID: "\(list.name)Style",
                    styles: [
                    PerLevelPoiStyle(iconStyle: placeIconStyle, level: 5),
                    PerLevelPoiStyle(iconStyle: placeIconStyle, level: 12)
                ])
                
                manager.addPoiStyle(placePoiStyle)
                
                let poi = layer?.getPoi(poiID: "\(list.name)")
                poi?.changeStyle(styleID: "\(list.name)Style")
            }
        }
        
        let userPoiOption = PoiOptions(styleID: "userStyle", poiID: String("user"))
        
        guard let userMapPoint = userMapPoint else { return }
        let cameraPosition = CameraPosition(target: userMapPoint, zoomLevel: 10, rotation: 0, tilt: 0)
        let cameraUpdate = CameraUpdate.make(cameraPosition: cameraPosition)
        
        view.moveCamera(cameraUpdate)
        
        let _ = layer?.addPoi(option: userPoiOption, at: userMapPoint)
        let _ = layer?.addPois(options: poiOptions, at: poiList)
        layer?.showAllPois()
    }
    
}

//MARK: Route
extension KakaoMapCoordinator {
    
    func createRouteLayer() {
        guard let view = controller?.getView("mapview") as? KakaoMap else { return }
        let manager = view.getRouteManager()
        
        let _ = manager.addRouteLayer(layerID: "RouteLayer", zOrder: 1)
    }
    
    func createRouteStyleSet() {
        guard let view = controller?.getView("mapview") as? KakaoMap else { return }
        let manager = view.getRouteManager()
        
        let styleSet = RouteStyleSet(styleID: "RouteStyleSet")
        
        let perLevelRouteStyle = PerLevelRouteStyle(
            width: 4,
            color: .gray,
            level: 0,
            patternIndex: -1
        )
        
        let routeStyle = RouteStyle(styles: [perLevelRouteStyle])
        styleSet.addStyle(routeStyle)
        
        manager.addRouteStyleSet(styleSet)
    }
    
    func routeSegmentPoints(list: [MapPoint]) -> [[MapPoint]] {
        
        var segmentPoints: [[MapPoint]] = []
        
        for index in 0..<list.count - 1 {
            let segment = [list[index], list[index + 1]]
            segmentPoints.append(segment)
        }
        
        return segmentPoints
    }
    
    func updateRouteLine() {
        
        guard let view = controller?.getView("mapview") as? KakaoMap else { return }
        let manager = view.getRouteManager()
        
        let layer = manager.getRouteLayer(layerID: "RouteLayer")
        
        layer?.removeRoute(routeID: "CourseRoute")
        
        let pointList = placeList.map {
            return MapPoint(longitude: $0.gpsX, latitude: $0.gpsY)
        }
        
        let segmentPoints = routeSegmentPoints(list: pointList)
        var segments: [RouteSegment] = []
        var styleIndex: UInt = 0

        for points in segmentPoints {
            let seg = RouteSegment(points: points, styleIndex: styleIndex)
            segments.append(seg)
        }

        let routeOptions = RouteOptions(routeID: "CourseRoute", styleID: "RouteStyleSet", zOrder: 1)
        routeOptions.segments = segments
        
        let route = layer?.addRoute(option: routeOptions)
        route?.show()
        
    }
    
}
