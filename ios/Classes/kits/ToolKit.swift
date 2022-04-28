//
//  ToolKit.swift
//  amap_kit
//
//  Created by 杜刚 on 2022/4/25.
//

import Foundation

class ToolKit: NSObject {
    static let instance = ToolKit()

    override private init() {}

    // 检查本机地图安装
    func checkNativeMaps(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let amap = UIApplication.shared.canOpenURL(URL(string: "iosamap://")!)
        let bmap = UIApplication.shared.canOpenURL(URL(string: "baidumap://")!)
        result(["amap": amap, "bmap": bmap])
    }
    
    // 计算两点间直线距离
    func calculateLineDistance(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let lat1 = args["lat1"] as! NSNumber
        let lon1 = args["lon1"] as! NSNumber
        let lat2 = args["lat2"] as! NSNumber
        let lon2 = args["lon2"] as! NSNumber

        let origin = MAMapPointForCoordinate(CLLocationCoordinate2D(latitude: lat1.doubleValue, longitude: lon1.doubleValue))
        let destination = MAMapPointForCoordinate(CLLocationCoordinate2D(latitude: lat2.doubleValue, longitude: lon2.doubleValue))
        let distance = MAMetersBetweenMapPoints(origin, destination)
        result(distance)
    }
    
    // 坐标系转换
    func coordinateConvert(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let lat = args["lat"] as! NSNumber
        let lon = args["lon"] as! NSNumber
        let from = args["from"] as! NSInteger

        let coord = AMapCoordinateConvert(CLLocationCoordinate2D(latitude: lat.doubleValue, longitude: lon.doubleValue), AMapCoordinateType(rawValue: from)!)
        result(["lat": coord.latitude, "lng": coord.longitude])
    }
}

