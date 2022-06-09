package com.yuro.amap_kit.kits

import android.content.Context
import android.util.Log
import com.amap.api.location.AMapLocation
import com.amap.api.location.AMapLocationClient
import com.amap.api.location.AMapLocationClientOption
import com.amap.api.location.AMapLocationListener
import com.yuro.amap_kit.AmapKitPlugin
import com.yuro.amap_kit.util.Bid
import com.yuro.amap_kit.util.Kid
import com.yuro.amap_kit.util.toMap
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

object LocationKit {
    private val map = mutableMapOf<Long, LocationImpl>()

    private fun getLocationOption(call: MethodCall): AMapLocationClientOption {
        val locationOption = AMapLocationClientOption()
        call.argument<Int>("locationMode")?.let {
            locationOption.locationMode = AMapLocationClientOption.AMapLocationMode.values()[it]
        }
        call.argument<Int>("locationPurpose")?.let {
            locationOption.locationPurpose = AMapLocationClientOption.AMapLocationPurpose.values()[it]
        }
        call.argument<Boolean>("isOnceLocation")?.let {
            locationOption.isOnceLocation = it
        }
        call.argument<Boolean>("isOnceLocationLatest")?.let {
            locationOption.isOnceLocationLatest = it
        }
        call.argument<Long>("interval")?.let {
            locationOption.interval = it
        }
        call.argument<Boolean>("isNeedAddress")?.let {
            locationOption.isNeedAddress = it
        }
        call.argument<Boolean>("isMockEnable")?.let {
            locationOption.isMockEnable = it
        }
        call.argument<Long>("httpTimeOut")?.let {
            locationOption.httpTimeOut = it
        }
        call.argument<Boolean>("isLocationCacheEnable")?.let {
            locationOption.isLocationCacheEnable = it
        }
        call.argument<Boolean>("isWifiScan")?.let {
            locationOption.isWifiScan = it
        }
        call.argument<Int>("locationProtocol")?.let {
            AMapLocationClientOption.setLocationProtocol(AMapLocationClientOption.AMapLocationProtocol.values()[it])
        }
        return locationOption
    }

    fun startLocation(context: Context, call: MethodCall, result: MethodChannel.Result) {
        try {
            val locationId = call.argument<Long>("locationId")!!
            val options = getLocationOption(call)
            val locationImpl = LocationImpl(context, locationId).apply { start(options) }
            if (!options.isOnceLocation) map[locationId] = locationImpl
            result.success(true)
        } catch (e: Exception) {
            Log.e("AmapKit|Location", "startLocation: ${e.message ?: e.localizedMessage}")
            result.success(false)
        }
    }

    fun stopLocation(call: MethodCall, result: MethodChannel.Result) {
        try {
            val locationId = call.argument<Long>("locationId")!!
            map.remove(locationId)?.stop()
            result.success(true)
        } catch (e: Exception) {
            Log.e("AmapKit|Location", "stopLocation: ${e.message ?: e.localizedMessage}")
            result.success(false)
        }
    }


    private class LocationImpl(context: Context, val locationId: Long) : AMapLocationListener {

        private val aMapLocationClient = AMapLocationClient(context)

        fun start(option: AMapLocationClientOption) {
            aMapLocationClient.setLocationOption(option)
            aMapLocationClient.setLocationListener(this)
            aMapLocationClient.startLocation()
            Log.d("AmapKit|Location", "start: $locationId")
        }

        fun stop() {
            aMapLocationClient.stopLocation()
            Log.d("AmapKit|Location", "stop: $locationId")
        }

        override fun onLocationChanged(p0: AMapLocation?) {
            Log.d("AmapKit|Location", "onLocationChanged: $locationId")
            p0?.let {
                if (it.errorCode == 0) {
                    AmapKitPlugin.send(Kid.LOCATION, Bid.LOCATION, 0, it.toMap(locationId))
                } else {
                    AmapKitPlugin.send(Kid.LOCATION, Bid.LOCATION, it.errorCode, locationId)
                    aMapLocationClient.stopLocation()
                }
            }
        }

    }
}