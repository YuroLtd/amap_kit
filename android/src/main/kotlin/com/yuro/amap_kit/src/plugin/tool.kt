package com.yuro.amap_kit.src.plugin

import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.util.Log
import com.amap.api.location.CoordinateConverter
import com.amap.api.location.DPoint
import com.yuro.amap_kit.AmapKitPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import java.util.*

object ToolPlugin {
    /**
     * 计算两个坐标点的距离
     */
    fun calculateLineDistance(call: MethodCall, result: MethodChannel.Result) {
        try {
            val ll1 = call.argument<Map<String, Double>>("ll1")
            val ll2 = call.argument<Map<String, Double>>("ll2")
            if (ll1 == null || ll2 == null) throw IllegalArgumentException("参数缺失")

            val dp1 = DPoint(ll1["lat"]!!, ll1["lng"]!!)
            val dp2 = DPoint(ll2["lat"]!!, ll2["lng"]!!)
            val distance = CoordinateConverter.calculateLineDistance(dp1, dp2)
            result.success(distance)
        } catch (e: Exception) {
            result.error(e.message, e.localizedMessage, e)
        }
    }

    /**
     * 坐标系切换
     */
    fun coordinateConvert(context: Context, call: MethodCall, result: MethodChannel.Result) {
        try {
            val source = call.argument<Map<String, Double>>("source") ?: throw IllegalArgumentException("参数缺失")
            val sourceDPoint = DPoint(source["lat"]!!, source["lng"]!!)
            val from = call.argument<Int>("from")!!
            val dPoint = CoordinateConverter(context).from(CoordinateConverter.CoordType.values()[from]).coord(sourceDPoint).convert()
            result.success(mapOf("lat" to dPoint.latitude, "lng" to dPoint.longitude))
        } catch (e: Exception) {
            result.error(e.message, e.localizedMessage, e)
        }
    }
}