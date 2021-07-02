package com.yuro.amap_kit

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.amap.api.location.AMapLocation
import com.amap.api.location.AMapLocationClient
import com.amap.api.location.AMapLocationClientOption
import com.amap.api.location.AMapLocationListener
import com.yuro.amap_kit.AmapKitPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

object LocationPlugin {
    private val locationImplMap = mutableMapOf<String, LocationImpl>()

    fun startLocation(context: Context, @NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        try {
            val optionMap = call.argument<Map<String, Any>>("options")!!
            val locationOption = AMapLocationClientOption()
            optionMap["locationMode"]?.let {
                locationOption.locationMode = AMapLocationClientOption.AMapLocationMode.valueOf(it as String)
            }
            optionMap["locationPurpose"]?.let {
                locationOption.locationPurpose = AMapLocationClientOption.AMapLocationPurpose.valueOf(it as String)
            }
            optionMap["isOnceLocation"]?.let {
                locationOption.isOnceLocation = it as Boolean
            }
            optionMap["isOnceLocationLatest"]?.let {
                locationOption.isOnceLocationLatest = it as Boolean
            }
            optionMap["interval"]?.let {
                locationOption.interval = it as Long
            }
            optionMap["isNeedAddress"]?.let {
                locationOption.isNeedAddress = it as Boolean
            }
            optionMap["isMockEnable"]?.let {
                locationOption.isMockEnable = it as Boolean
            }
            optionMap["httpTimeOut"]?.let {
                locationOption.httpTimeOut = it as Long
            }
            optionMap["isLocationCacheEnable"]?.let {
                locationOption.isLocationCacheEnable = it as Boolean
            }
            optionMap["isWifiScan"]?.let {
                locationOption.isWifiScan = it as Boolean
            }
            optionMap["locationProtocol"]?.let {
                AMapLocationClientOption.setLocationProtocol(AMapLocationClientOption.AMapLocationProtocol.valueOf(it as String))
            }
            val locationId = call.argument<String>("locationId")!!
            locationImplMap[locationId] = LocationImpl(context).apply {
                startLocation(locationOption)
            }
            result.success(locationId)
        } catch (e: Exception) {
            result.error(e.message, e.localizedMessage, e)
        }
    }

    fun stopLocation(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        try {
            val locationId = call.arguments as String
            locationImplMap[locationId]?.stopLocation()
        } catch (e: Exception) {
            result.error(e.message, e.localizedMessage, e)
        }
    }

    private class LocationImpl(context: Context) : AMapLocationListener {
        private val aMapLocationClient = AMapLocationClient(context)

        fun startLocation(locationClientOption: AMapLocationClientOption) {
            aMapLocationClient.setLocationOption(locationClientOption)
            aMapLocationClient.setLocationListener(this)
            aMapLocationClient.startLocation()
        }

        fun stopLocation() {
            aMapLocationClient.stopLocation()
        }

        override fun onLocationChanged(amapLocation: AMapLocation?) {
            amapLocation?.let {
                if (it.errorCode == 0) {
                    AmapKitPlugin.sendSuccessEventSink("location", it.toMap())
                } else {
                    AmapKitPlugin.sendErrorEventSink(it.errorCode.toString(), it.errorInfo)
                    aMapLocationClient.stopLocation()
                }
            }
        }
    }
}

fun AMapLocation.toMap(): Map<String, Any> = mutableMapOf(
    "latitude" to latitude,
    "longitude" to longitude,
    "altitude" to altitude,
    "accuracy" to accuracy,
    "address" to address,
    "country" to country,
    "province" to province,
    "city" to city,
    "district" to district,
    "street" to street,
    "streetNum" to streetNum,
    "floor" to floor,
    "cityCode" to cityCode,
    "adCode" to adCode,
    "aoiName" to aoiName,
    "poiName" to poiName,
    "description" to description,
    "speed" to speed,
    "bearing" to bearing
)

