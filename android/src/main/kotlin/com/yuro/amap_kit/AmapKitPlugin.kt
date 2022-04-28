package com.yuro.amap_kit

import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.amap.api.location.AMapLocationClient
import com.amap.api.maps.MapsInitializer
import com.amap.api.services.core.ServiceSettings
import com.yuro.amap_kit.kits.LocationKit
import com.yuro.amap_kit.kits.NavigateKit
import com.yuro.amap_kit.kits.SearchKit
import com.yuro.amap_kit.kits.ToolKit
import com.yuro.amap_kit.util.Bid
import com.yuro.amap_kit.util.Kid

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AmapKitPlugin */
class AmapKitPlugin : FlutterPlugin, ActivityAware, MethodCallHandler, EventChannel.StreamHandler {
    companion object {
        private const val METHOD_CHANNEL = "plugin.yuro.com/amap_kit.method"
        private const val EVENT_CHANNEL = "plugin.yuro.com/amap_kit.event"

        private var eventSink: EventChannel.EventSink? = null

        fun send(kid: Kid, bid: Bid, code: Int, data: Any? = null) {
            eventSink?.success(mapOf("kid" to kid.value, "bid" to bid.value, "code" to code, "data" to data))
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

    override fun onListen(p0: Any?, p1: EventChannel.EventSink?) {
        eventSink = p1
    }

    override fun onCancel(p0: Any?) {
        eventSink = null
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    override fun onAttachedToActivity(p0: ActivityPluginBinding) {
        activity = p0.activity
    }


    override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {
        activity = p0.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onDetachedFromActivity() {

    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d("AmapKit", "onMethodCall: ${call.method},${call.arguments}")
        when (call.method) {
            "setApiKey" -> setApiKey(activity, call, result)
            // location
            "startLocation" -> LocationKit.startLocation(activity, call,result)
            "stopLocation" -> LocationKit.stopLocation(call,result)

            // geofence
//            "addGeoFence" -> LocationPlugin.addGeoFence(call, result)
//            "pauseGeoFence" -> LocationPlugin.pauseGeoFence(call, result)
//            "resumeGeoFence" -> LocationPlugin.resumeGeoFence(call, result)
//            "setGeoFenceAble" -> LocationPlugin.setGeoFenceAble(call, result)
//            "removeGeoFence" -> LocationPlugin.removeGeoFence(call, result)

            // search
            "weatherSearch" -> SearchKit.weatherSearch(activity, call)
            // navigate
            "amapNav" -> NavigateKit.amapNav(activity, call)
            "bmapNav" -> NavigateKit.bmapNav(activity, call)

            // tool
            "checkNativeMaps" -> ToolKit.checkNativeMaps(activity, result)
            "calculateLineDistance" -> ToolKit.calculateLineDistance(call, result)
            "coordinateConvert" -> ToolKit.coordinateConvert(activity, call, result)
            else -> result.notImplemented()
        }
    }


    private fun setApiKey(context: Context, call: MethodCall, result: Result) {
        try {
            val isContains = call.argument<Boolean>("isContains")!!
            val isShow = call.argument<Boolean>("isShow")!!
            val isAgree = call.argument<Boolean>("isAgree")!!

            AMapLocationClient.updatePrivacyShow(context, isContains, isShow)
            MapsInitializer.updatePrivacyShow(context, isContains, isShow)
            ServiceSettings.updatePrivacyShow(context, isContains, isShow)

            AMapLocationClient.updatePrivacyAgree(context, isAgree)
            MapsInitializer.updatePrivacyAgree(context, isAgree)
            ServiceSettings.updatePrivacyAgree(context, isAgree)

            //设置ApiKey
            val androidKey = call.argument<String>("android")!!
            MapsInitializer.setApiKey(androidKey)
            AMapLocationClient.setApiKey(androidKey)
            result.success(true)
        } catch (e: Exception) {
            result.success(false)
        }
    }

}
