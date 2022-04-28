//
//  SearchKit.swift
//  amap_kit
//
//  Created by 杜刚 on 2022/4/25.
//

import Foundation

class SearchKit: NSObject, AMapSearchDelegate {
    static let instance = SearchKit()

    override private init() {}

    private lazy var search = AMapSearchAPI()
    private var distanceResult: FlutterResult?

    // 计算两个点的距离
    func calculateDistance(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let lat1 = args["lat1"] as! NSNumber
        let lon1 = args["lon1"] as! NSNumber
        let lat2 = args["lat2"] as! NSNumber
        let lon2 = args["lon2"] as! NSNumber

        distanceResult = result

        let request = AMapDistanceSearchRequest()
        request.origins = [AMapGeoPoint.location(withLatitude: CGFloat(lat1.doubleValue), longitude: CGFloat(lon1.doubleValue))!]
        request.destination = AMapGeoPoint.location(withLatitude: CGFloat(lat2.doubleValue), longitude: CGFloat(lon2.doubleValue))
        search!.delegate = self
        search!.aMapDistanceSearch(request)
    }

    // 查询城市天气信息
    func weatherSearch(call: FlutterMethodCall) {
        let args = call.arguments as! [String: Any]
        let city = args["city"] as! String
        let type = args["type"] as! NSInteger

        let request = AMapWeatherSearchRequest()
        request.city = city
        request.type = type == 1 ? AMapWeatherType.live : AMapWeatherType.forecast
        search!.delegate = self
        search!.aMapWeatherSearch(request)
    }

    func onDistanceSearchDone(_ request: AMapDistanceSearchRequest!, response: AMapDistanceSearchResponse!) {
        if response.results != nil, !response.results.isEmpty {
            distanceResult?(NSNumber(value: response.results.first!.distance).doubleValue)
        } else {
            distanceResult?(nil)
        }
        distanceResult = nil
    }

    func onWeatherSearchDone(_ request: AMapWeatherSearchRequest!, response: AMapWeatherSearchResponse!) {
        if response.lives != nil {
            if response.lives.isEmpty {
                SwiftAmapKitPlugin.streamHandler.send(kid: Kid.search, bid: Bid.weatherLive, code: -2, data: nil)
            } else {
                let weather = response.lives.first!
                let result = [
                    "adCode": weather.adcode!,
                    "province": weather.province!,
                    "city": weather.city!,
                    "reportTime": weather.reportTime!,
                    "humidity": weather.humidity!,
                    "temperature": weather.temperature!,
                    "weather": weather.weather!,
                    "windDirection": weather.windDirection!,
                    "windPower": weather.windPower!
                ]
                SwiftAmapKitPlugin.streamHandler.send(kid: Kid.search, bid: Bid.weatherLive, code: 0, data: result)
            }

        } else if response.forecasts != nil {
            if response.forecasts.isEmpty {
                SwiftAmapKitPlugin.streamHandler.send(kid: Kid.search, bid: Bid.weatherForecast, code: -2, data: nil)
            } else {
                let weather = response.forecasts.first!
                var forecasts = [[String: String]]()
                weather.casts.forEach { item in
                    let forecast = [
                        "date": item.date!,
                        "dayTemp": item.dayTemp!,
                        "dayWeather": item.dayWeather!,
                        "dayWindDirection": item.dayWind!,
                        "dayWindPower": item.dayPower!,
                        "nightTemp": item.nightTemp!,
                        "nightWeather": item.nightWeather!,
                        "nightWindDirection": item.nightWind!,
                        "nightWindPower": item.nightPower!
                    ]
                    forecasts += [forecast]
                }

                let result = [
                    "adCode": weather.adcode!,
                    "province": weather.province!,
                    "city": weather.city!,
                    "reportTime": weather.reportTime!,
                    "forecasts": forecasts
                ] as [String: Any]
                SwiftAmapKitPlugin.streamHandler.send(kid: Kid.search, bid: Bid.weatherForecast, code: 0, data: result)
            }
        }
    }

    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        print(error!)
        if request is AMapWeatherSearchRequest {
            let weatherReq = request as! AMapWeatherSearchRequest
            let bid = weatherReq.type.rawValue == 1 ? Bid.weatherLive : Bid.weatherForecast
            SwiftAmapKitPlugin.streamHandler.send(kid: Kid.search, bid: bid, code: -1, data: nil)
        }
    }
}
