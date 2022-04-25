package com.yuro.amap_kit.util

enum class Kid(val value:Int) {
    /**
     * 定位
     */
    LOCATION(10),

    /**
     * 搜索
     */
    SEARCH(20),

    /**
     * 导航
     */
    NAVIGATION(30),

    /**
     * 工具
     */
    TOOL(40),
}


enum class Bid(val value: Int) {
    /**
     * 定位数据返回
     */
    LOCATION(11),

    /**
     * 实时天气返回
     */
    WEATHER_LIVE(21),

    /**
     * 预报天气返回
     */
    WEATHER_FORECAST(22),
}