//
//  NavigateKit.swift
//  amap_kit
//
//  Created by 杜刚 on 2022/4/25.
//

import Foundation

class NavigateKit: NSObject {
    static let instance = NavigateKit()

    override private init() {}
    
    // 调起高德地图进行导航
    func amapNav(call: FlutterMethodCall) {
        let args = call.arguments as! [String: Any]
        let src = args["src"] as! String
        let lat = args["lat"] as! NSNumber
        let lon = args["lon"] as! NSNumber
        
        var schema = "iosamap://navi?sourceApplication="
        schema += src
        schema += "&lat="
        schema += lat.stringValue
        schema += "&lon="
        schema += lon.stringValue
        schema += "&dev=0"
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: schema)!)
        } else {
            UIApplication.shared.openURL(URL(string: schema)!)
        }
    }
    
    // 调起百度地图进行导航
    func bmapNav(call: FlutterMethodCall) {
        let args = call.arguments as! [String: Any]
        let location = args["location"] as! String
        let src = args["src"] as! String
        
        var schema = "baidumap://map/navi?location="
        schema += location
        schema += "&src="
        schema += src
        schema += "&coord_type=bd09ll"
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: schema)!)
        } else {
            UIApplication.shared.openURL(URL(string: schema)!)
        }
    }
}
