package com.yuro.amap_kit

import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.util.Log
import androidx.annotation.NonNull
import com.amap.api.location.AMapLocationClient
import com.amap.api.maps.MapsInitializer
import com.yuro.amap_kit.src.plugin.LocationPlugin
import com.yuro.amap_kit.src.plugin.NavigationPlugin
import com.yuro.amap_kit.src.plugin.SearchPlugin
import com.yuro.amap_kit.src.plugin.ToolPlugin
import com.yuro.amap_kit.src.util.Bid
import com.yuro.amap_kit.src.util.ErrorCode
import com.yuro.amap_kit.src.util.Tid
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import java.util.*

/** AmapKitPlugin */
class AmapKitPlugin : FlutterPlugin, ActivityAware, MethodCallHandler, EventChannel.StreamHandler {
    companion object {
        const val TAG = "AmapKit"
        private const val METHOD_CHANNEL = "plugin.yuro.com/amap_kit.method"
        private const val EVENT_CHANNEL = "plugin.yuro.com/amap_kit.event"

        private var eventSink: EventChannel.EventSink? = null

        fun sendSuccess(tid: Tid, bid: Bid, data: Any? = null) {
            eventSink?.success(mapOf("tid" to tid.name, "bid" to bid.value, "data" to data))
        }

        fun sendError(error: ErrorCode, message: String? = null, e: Throwable? = null) {
            eventSink?.error(error.value.toString(), message ?: error.name, e)
        }
    }

    private lateinit var activity: Activity
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL)
        methodChannel.setMethodCallHandler(this)

        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, EVENT_CHANNEL)
        eventChannel.setStreamHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    override fun onListen(p0: Any?, p1: EventChannel.EventSink?) {
        eventSink = p1
    }

    override fun onCancel(p0: Any?) {
        eventSink = null
    }

    override fun onAttachedToActivity(p0: ActivityPluginBinding) {
        activity = p0.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {

    }

    override fun onDetachedFromActivity() {

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d(TAG, "onMethodCall: ${call.method},${call.arguments}")
        when (call.method) {
            // location
            "startLocation" -> LocationPlugin.startLocation(activity, call)
            "stopLocation" -> LocationPlugin.stopLocation()

            // geofence
//            "addGeoFence" -> LocationPlugin.addGeoFence(call, result)
//            "pauseGeoFence" -> LocationPlugin.pauseGeoFence(call, result)
//            "resumeGeoFence" -> LocationPlugin.resumeGeoFence(call, result)
//            "setGeoFenceAble" -> LocationPlugin.setGeoFenceAble(call, result)
//            "removeGeoFence" -> LocationPlugin.removeGeoFence(call, result)

            // search
            "weatherSearch" -> SearchPlugin.weatherSearch(activity, call)

            // navigation
            "checkNativeMaps" -> NavigationPlugin.checkNativeMaps(activity, result)
            "amapNav" -> NavigationPlugin.amapNav(activity, call)
            "bmapNav" -> NavigationPlugin.bmapNav(activity, call)

            // tool
            "setApiKey" -> ToolPlugin.setApiKey(activity, call, result)
            "calculateLineDistance" -> ToolPlugin.calculateLineDistance(call, result)
            "coordinateConvert" -> ToolPlugin.coordinateConvert(activity, call, result)
            else -> result.notImplemented()
        }
    }
}
