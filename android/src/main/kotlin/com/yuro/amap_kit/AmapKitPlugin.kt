package com.yuro.amap_kit

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.amap.api.location.AMapLocationClient
import com.amap.api.location.CoordinateConverter
import com.amap.api.location.DPoint
import com.amap.api.maps.MapsInitializer
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AmapKitPlugin */
class AmapKitPlugin : FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler {
    companion object {
        private const val TAG = "AmapKit"
        private const val METHOD_CHANNEL = "plugin.yuro.com/amap_kit.method"
        private const val EVENT_CHANNEL = "plugin.yuro.com/amap_kit.event"

        private var eventSink: EventChannel.EventSink? = null

        fun sendSuccessEventSink(type: String, data: Map<String, Any>) {
            eventSink?.success(mapOf("type" to type, "data" to data))
        }

        fun sendErrorEventSink(code: String, message: String) {
            eventSink?.error(code, message, null)
        }
    }

    private lateinit var context: Context
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.d(TAG, "onAttachedToEngine")
        context = flutterPluginBinding.applicationContext

        methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL)
        methodChannel.setMethodCallHandler(this)

        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, EVENT_CHANNEL)
        eventChannel.setStreamHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        Log.d(TAG, "onDetachedFromEngine")
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    override fun onListen(p0: Any?, p1: EventChannel.EventSink?) {
        Log.d(TAG, "onListen")
        eventSink = p1
    }

    override fun onCancel(p0: Any?) {
        Log.d(TAG, "onCancel")
        eventSink = null
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d(TAG, "onMethodCall: ${call.method},${call.arguments}")
        when (call.method) {
            "setApiKey" -> {
                val androidKey = call.argument<String>("androidKey")
                MapsInitializer.setApiKey(androidKey)
                AMapLocationClient.setApiKey(androidKey)
            }
            //
            "calculateLineDistance" -> calculateLineDistance(call, result)
            "coordinateConvert" -> coordinateConvert(call, result)
            //
            "startLocation" -> LocationPlugin.startLocation(context, call, result)
            "stopLocation" -> LocationPlugin.stopLocation(call, result)
            //
//            "addGeoFence" -> LocationPlugin.addGeoFence(call, result)
//            "pauseGeoFence" -> LocationPlugin.pauseGeoFence(call, result)
//            "resumeGeoFence" -> LocationPlugin.resumeGeoFence(call, result)
//            "setGeoFenceAble" -> LocationPlugin.setGeoFenceAble(call, result)
//            "removeGeoFence" -> LocationPlugin.removeGeoFence(call, result)

            "weatherSearch" -> SearchPlugin.weatherSearch(context, call)

            else -> result.notImplemented()
        }
    }

    /**
     * 计算两个坐标点的距离
     */
    private fun calculateLineDistance(call: MethodCall, result: Result) {
        try {
            val ll1 = call.argument<Map<String, Double>>("ll1")
            val ll2 = call.argument<Map<String, Double>>("ll2")
            if (ll1 == null || ll2 == null) {
                throw IllegalArgumentException("参数缺失")
            }
            val dp1 = DPoint(ll1["latitude"]!!, ll1["longitude"]!!)
            val dp2 = DPoint(ll2["latitude"]!!, ll2["longitude"]!!)
            val distance = CoordinateConverter.calculateLineDistance(dp1, dp2)
            result.success(distance)
        } catch (e: Exception) {
            result.error(e.message, e.localizedMessage, e)
        }
    }

    /**
     * 坐标系切换
     */
    private fun coordinateConvert(call: MethodCall, result: Result) {
        try {
            val source = call.argument<Map<String, Double>>("source") ?: throw IllegalArgumentException("参数缺失")
            val sourceDPoint = DPoint(source["latitude"]!!, source["longitude"]!!)
            val from = call.argument<Int>("from")!!
            val dPoint = CoordinateConverter(context).from(CoordinateConverter.CoordType.values()[from]).coord(sourceDPoint).convert()
            result.success(mapOf("latitude" to dPoint.latitude, "longitude" to dPoint.longitude))
        } catch (e: Exception) {
            result.error(e.message, e.localizedMessage, e)
        }
    }
}
