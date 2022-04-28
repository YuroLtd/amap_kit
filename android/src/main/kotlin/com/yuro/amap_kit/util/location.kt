package com.yuro.amap_kit.util

import com.amap.api.location.AMapLocation

fun AMapLocation.toMap(locationId: Long): Map<String, Any> = mutableMapOf(
        "locationId" to locationId,
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
        "speed" to speed,
        "bearing" to bearing
)