package com.yuro.amap_kit.kits

import android.content.Context
import android.util.Log
import com.amap.api.location.CoordinateConverter
import com.amap.api.location.DPoint
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

object ToolKit {
    /**
     * 检查本机地图安装情况
     */
    fun checkNativeMaps(context: Context, result: MethodChannel.Result) {
        val amap = try {
            context.packageManager.getPackageInfo("com.autonavi.minimap", 0)
            true
        } catch (e: Exception) {
            false
        }
        val bmap = try {
            context.packageManager.getPackageInfo("com.baidu.BaiduMap", 0)
            true
        } catch (e: Exception) {
            false
        }
        result.success(mapOf("amap" to amap, "bmap" to bmap))
    }

    /**
     * 计算两个坐标点的直线距离
     */
    fun calculateLineDistance(call: MethodCall, result: MethodChannel.Result) {
        try {
            val lat1 = call.argument<Double>("lat1")!!
            val lon1 = call.argument<Double>("lon1")!!
            val lat2 = call.argument<Double>("lat2")!!
            val lon2 = call.argument<Double>("lon2")!!
            val dp1 = DPoint(lat1, lon1)
            val dp2 = DPoint(lat2, lon2)
            val distance = CoordinateConverter.calculateLineDistance(dp1, dp2)
            result.success(distance)
        } catch (e: Exception) {
            Log.d("AmapKit|ToolKit", "calculateLineDistance: ${e.message ?: e.localizedMessage}")
        }
    }

    /**
     * 坐标系切换
     */
    fun coordinateConvert(context: Context, call: MethodCall, result: MethodChannel.Result) {
        try {
            val lat = call.argument<Double>("lat")!!
            val lon = call.argument<Double>("lon")!!
            val sourceDPoint = DPoint(lat,lon)
            val from = call.argument<Int>("from")!!
            val dPoint = CoordinateConverter(context).from(CoordinateConverter.CoordType.values()[from]).coord(sourceDPoint).convert()
            result.success(mapOf("lat" to dPoint.latitude, "lng" to dPoint.longitude))
        } catch (e: Exception) {
            Log.d("AmapKit|ToolKit", "coordinateConvert: ${e.message ?: e.localizedMessage}")
        }
    }
}