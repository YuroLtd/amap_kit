//
//  LocationKit.swift
//  amap_kit
//
//  Created by 杜刚 on 2022/4/25.
//

import CoreLocation
import Foundation

class LocationKit: NSObject {
    static let instance = LocationKit()
    private static var _implMap = [Int: AMapLocationManagerImpl]()
    
    override private init() {}
    
    func startLocation(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let locationId = args["locationId"] as! Int
        
        let isOnceLocation = args["isOnceLocation"] as? Bool
        let desiredAccuracy = args["desiredAccuracy"] as? Int
        let pausesLocationUpdates = args["pausesLocationUpdates"] as? Bool
        let distanceFilter = args["distanceFilter"] as? Double
        let authorizationMode = args["authorizationMode"] as? Int
        let fullAccuracyPurposeKey = args["fullAccuracyPurposeKey"] as? Int
     
        let locationOptions = AMapLocationOptions(
            _oneceLocation: isOnceLocation ?? false,
            _desiredAccuracy: desiredAccuracy,
            _pausesLocationUpdates: pausesLocationUpdates,
            _distanceFilter: distanceFilter,
            _authorizationMode: authorizationMode,
            _fullAccuracyPurposeKey: fullAccuracyPurposeKey
        )
        let impl = AMapLocationManagerImpl(locationId: locationId, options: locationOptions)
        if !locationOptions.oneceLocation {
            LocationKit._implMap[locationId] = impl
        }
        impl.startLocation()
        result(true)
    }
    
    func stopLocation(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let locationId = args["locationId"] as! Int
        
        let impl = LocationKit._implMap.removeValue(forKey: locationId)
        impl?.stopLocation()
        result(true)
    }
}

class AMapLocationManagerImpl: NSObject, AMapLocationManagerDelegate {
    private let locationManager = AMapLocationManager()
    
    private let locationId: Int
    private let options: AMapLocationOptions
   
    init(locationId: Int, options: AMapLocationOptions) {
        self.locationId = locationId
        self.options = options
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func startLocation() {
        locationManager.delegate = self
        if options.oneceLocation {
            startOnceLocation()
        }else{
            startUpdateLocation()
        }
    }
    
    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    private func startOnceLocation() {
        locationManager.desiredAccuracy = options.getDesiredAccuracy()
        locationManager.locationTimeout = options.getTimeout()
        locationManager.reGeocodeTimeout = options.getReGeocodeTimeout()
        locationManager.requestLocation(withReGeocode: true, completionBlock: { (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            let errorCode = Int32((error as? NSError)?.code ?? 0)
            if errorCode == 0, location != nil, reGeocode != nil {
                var map = [String: Any]()
                map["locationId"] = self.locationId
                map["latitude"] = location!.coordinate.latitude
                map["longitude"] = location!.coordinate.longitude
                map["altitude"] = location!.altitude
                map["accuracy"] = location!.horizontalAccuracy
                map["address"] = reGeocode!.formattedAddress
                map["country"] = reGeocode!.country
                map["province"] = reGeocode!.province
                map["city"] = reGeocode!.city
                map["district"] = reGeocode!.district
                map["street"] = reGeocode!.street
                map["streetNum"] = reGeocode!.number
                map["floor"] = location!.floor
                map["cityCode"] = reGeocode!.citycode
                map["adCode"] = reGeocode!.adcode
                map["aoiName"] = reGeocode!.aoiName
                map["poiName"] = reGeocode!.poiName
                map["speed"] = location!.speed
                map["bearing"] = location!.course
                SwiftAmapKitPlugin.streamHandler.send(kid: Kid.location, bid: Bid.location, code: 0, data: map)
            } else {
                SwiftAmapKitPlugin.streamHandler.send(kid: Kid.location, bid: Bid.location, code: errorCode, data: self.locationId)
            }
        })
    }
    
    private func startUpdateLocation(){
        locationManager.distanceFilter = options.distanceFilter ?? 100
        locationManager.locatingWithReGeocode = true
        locationManager.pausesLocationUpdatesAutomatically = options.pausesLocationUpdates ?? false
        locationManager.startUpdatingLocation()
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        if location != nil, reGeocode != nil {
            var map = [String: Any]()
            map["locationId"] = self.locationId
            map["latitude"] = location!.coordinate.latitude
            map["longitude"] = location!.coordinate.longitude
            map["altitude"] = location!.altitude
            map["accuracy"] = location!.horizontalAccuracy
            map["address"] = reGeocode!.formattedAddress
            map["country"] = reGeocode!.country
            map["province"] = reGeocode!.province
            map["city"] = reGeocode!.city
            map["district"] = reGeocode!.district
            map["street"] = reGeocode!.street
            map["streetNum"] = reGeocode!.number
            map["floor"] = location!.floor
            map["cityCode"] = reGeocode!.citycode
            map["adCode"] = reGeocode!.adcode
            map["aoiName"] = reGeocode!.aoiName
            map["poiName"] = reGeocode!.poiName
            map["speed"] = location!.speed
            map["bearing"] = location!.course
            SwiftAmapKitPlugin.streamHandler.send(kid: Kid.location, bid: Bid.location, code: 0, data: map)
        }
    }
}
   
class AMapLocationOptions: NSObject {
    // 是否是一次性定位
    var oneceLocation: Bool
    // 期望定位精度： CLLocationAccuracy
    var desiredAccuracy: Int?
    // 是否允许暂停定位
    var pausesLocationUpdates: Bool?
    // 定位更新距离
    var distanceFilter: Double?
    // ios14 授权模式
    var authorizationMode: Int?
    //
    var fullAccuracyPurposeKey: Int?
    
    init(
        _oneceLocation: Bool,
        _desiredAccuracy: Int?,
        _pausesLocationUpdates: Bool?,
        _distanceFilter: Double?,
        _authorizationMode: Int?,
        _fullAccuracyPurposeKey: Int?
    ) {
        self.oneceLocation = _oneceLocation
        self.desiredAccuracy = _desiredAccuracy
        self.pausesLocationUpdates = _pausesLocationUpdates
        self.distanceFilter = _distanceFilter
        self.authorizationMode = _authorizationMode
        self.fullAccuracyPurposeKey = _fullAccuracyPurposeKey
    }
    
    func getDesiredAccuracy() -> CLLocationAccuracy {
        switch desiredAccuracy {
            case 1:
                return kCLLocationAccuracyBestForNavigation
            case 2:
                return kCLLocationAccuracyNearestTenMeters
            case 3:
                return kCLLocationAccuracyHundredMeters
            case 4:
                return kCLLocationAccuracyKilometer
            case 5:
                return kCLLocationAccuracyThreeKilometers
            default:
                return kCLLocationAccuracyBest
        }
    }
    
    func getTimeout() -> Int {
        switch desiredAccuracy {
            case 1:
                return 2
            case 2:
                return 2
            case 3:
                return 2
            case 4:
                return 2
            case 5:
                return 2
            default:
                return 10
        }
    }
    
    func getReGeocodeTimeout() -> Int {
        switch desiredAccuracy {
            case 1:
                return 2
            case 2:
                return 2
            case 3:
                return 2
            case 4:
                return 2
            case 5:
                return 2
            default:
                return 10
        }
    }
    
    func getAuthorizationMode() -> AMapLocationAccuracyMode {
        switch authorizationMode {
            case 1:
                return AMapLocationAccuracyMode.fullAccuracy
            case 2:
                return AMapLocationAccuracyMode.reduceAccuracy
            default:
                return AMapLocationAccuracyMode.fullAndReduceAccuracy
        }
    }
}
