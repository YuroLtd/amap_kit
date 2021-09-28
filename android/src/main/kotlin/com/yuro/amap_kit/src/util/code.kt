package com.yuro.amap_kit.src.util

enum class Tid {
    /**
     * 定位
     */
    LOCATION,

    /**
     * 地理围栏
     */
    GEOFENCE,

    /**
     * 搜索
     */
    SEARCH,

    /**
     * 工具
     */
    TOOL,
}


enum class Bid(val value: Int) {
    LOCATION(10),
    WEATHER_LIVE(20),
    WEATHER_FORECAST(21),
}


enum class ErrorCode(val value: Int) {
    LOCATION_FAILED(100),
}