package com.yuro.amap_kit.src.plugin

import android.content.Context
import androidx.annotation.NonNull
import com.amap.api.location.AMapLocation
import com.amap.api.location.AMapLocationClient
import com.amap.api.location.AMapLocationClientOption
import com.amap.api.location.AMapLocationListener
import com.yuro.amap_kit.AmapKitPlugin
import com.yuro.amap_kit.src.util.Bid
import com.yuro.amap_kit.src.util.ErrorCode
import com.yuro.amap_kit.src.util.Tid
import io.flutter.plugin.common.MethodCall

object LocationPlugin {
    private var locationImpl: LocationImpl? = null

    /**
     * 启动定位
     */
    fun startLocation(context: Context, @NonNull call: MethodCall) {
        try {
            val locationOption = AMapLocationClientOption()
            call.argument<String>("locationMode")?.let {
                locationOption.locationMode = AMapLocationClientOption.AMapLocationMode.valueOf(it)
            }
            call.argument<String>("locationPurpose")?.let {
                locationOption.locationPurpose = AMapLocationClientOption.AMapLocationPurpose.valueOf(it)
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
            call.argument<String>("locationProtocol")?.let {
                AMapLocationClientOption.setLocationProtocol(AMapLocationClientOption.AMapLocationProtocol.valueOf(it))
            }
            locationImpl = LocationImpl(context).apply {
                startLocation(locationOption)
            }
        } catch (e: Exception) {

        }
    }

    /**
     * 停止定位
     */
    fun stopLocation() {
        locationImpl?.stopLocation()
        locationImpl = null
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
                    AmapKitPlugin.sendSuccess(Tid.LOCATION, Bid.LOCATION, it.toMap())
                } else {
                    AmapKitPlugin.sendError(ErrorCode.LOCATION_FAILED, it.errorInfo)
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

