import Flutter
import UIKit

public class SwiftAmapKitPlugin: NSObject, FlutterPlugin {
    static let AmapKitMethodName = "plugin.yuro.com/amap_kit.method"
    static let AmapKitEventName = "plugin.yuro.com/amap_kit.event"
    
    static let streamHandler = SwiftStreamHandler()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftAmapKitPlugin()
        let methodChannel = FlutterMethodChannel(name: AmapKitMethodName, binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: methodChannel)

        let eventChannel = FlutterEventChannel(name: AmapKitEventName, binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(streamHandler)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? [String: Any]
        print(call.method, args ?? "nil")
        switch call.method {
        case "setApiKey":
            let iosKey = args?["ios"] as! String
            AMapServices.shared().enableHTTPS = true
            AMapServices.shared().apiKey = iosKey

            //
            let isShow = args?["isShow"] as! Bool
            let showStatus = isShow ? AMapPrivacyShowStatus.didShow : AMapPrivacyShowStatus.notShow

            let isContains = args?["isContains"] as! Bool
            let privacyContains = isContains ? AMapPrivacyInfoStatus.didContain : AMapPrivacyInfoStatus.notContain

            AMapSearchAPI.updatePrivacyShow(showStatus, privacyInfo: privacyContains)
            AMapLocationManager.updatePrivacyShow(showStatus, privacyInfo: privacyContains)

            //
            let isAgree = args?["isAgree"] as! Bool
            let agreeStatus = isAgree ? AMapPrivacyAgreeStatus.didAgree : AMapPrivacyAgreeStatus.notAgree

            AMapSearchAPI.updatePrivacyAgree(agreeStatus)
            AMapLocationManager.updatePrivacyAgree(agreeStatus)

            result(true)
        // location
        case "startLocation":
            LocationKit.instance.startLocation(call: call, result: result)
        case "stopLocation":
            LocationKit.instance.stopLocation(call: call, result: result)
        // search
        case "weatherSearch":
            SearchKit.instance.weatherSearch(call: call)
        // nav
        case "amapNav":
            NavigateKit.instance.amapNav(call: call)
        case "bmapNav":
            NavigateKit.instance.bmapNav(call: call)
        case "calculateDistance":
            SearchKit.instance.calculateDistance(call: call, result: result)
        // tool
        case "checkNativeMaps":
            ToolKit.instance.checkNativeMaps(call: call, result: result)
        case "calculateLineDistance":
            ToolKit.instance.calculateLineDistance(call: call, result: result)
        case "coordinateConvert":
            ToolKit.instance.coordinateConvert(call: call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

// 业务分类
enum Kid: Int {
    case location = 10
    case search = 20
    case navigate = 30
    case tool = 40
}

// 业务结果
enum Bid: Int {
    case location = 11
    case weatherLive = 21
    case weatherForecast = 22
}

class SwiftStreamHandler: NSObject, FlutterStreamHandler {
    private var sink: FlutterEventSink?

    public func send(kid: Kid, bid: Bid, code: Int32, data: Any?) {
        self.sink?(["kid": kid.rawValue, "bid": bid.rawValue, "code": code, "data": data])
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.sink = events
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.sink = nil
        return nil
    }
}
