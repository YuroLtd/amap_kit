package com.yuro.amap_kit.kits

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

object NavigationKit {
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
     * 启动高德导航
     */
    fun amapNav(activity: Activity, call: MethodCall) {
        val sb = StringBuffer().apply {
            append("androidamap://navi?sourceApplication=").append(call.argument<String>("src"))
            append("&lat=").append(call.argument<Double>("lat"))
            append("&lon=").append(call.argument<Double>("lon"))
            append("&dev=0")
        }
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(sb.toString())).apply {
            setPackage("com.autonavi.minimap")
        }
        activity.startActivity(intent)
    }

    /**
     * 启动百度导航
     */
    fun bmapNav(activity: Activity, call: MethodCall) {
        val sb = StringBuffer().apply {
            append("baidumap://map/navi?location=").append(call.argument<String>("location"))
            append("&coord_type=bd09ll")
            append("&src=").append(call.argument<String>("src"))
        }
        activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(sb.toString())))
    }
}