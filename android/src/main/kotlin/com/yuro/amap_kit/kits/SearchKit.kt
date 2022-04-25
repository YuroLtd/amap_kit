package com.yuro.amap_kit.kits

import android.content.Context
import com.amap.api.services.weather.LocalWeatherForecastResult
import com.amap.api.services.weather.LocalWeatherLiveResult
import com.amap.api.services.weather.WeatherSearch
import com.amap.api.services.weather.WeatherSearchQuery
import com.yuro.amap_kit.AmapKitPlugin
import com.yuro.amap_kit.util.Bid
import com.yuro.amap_kit.util.Kid
import com.yuro.amap_kit.util.toMap
import io.flutter.plugin.common.MethodCall

object SearchKit {
    /**
     * 获取天气数据
     */
    fun weatherSearch(context: Context, call: MethodCall) {
        val city = call.argument<String>("city")!!
        val type = call.argument<Int>("type")!!
        val search = WeatherSearch(context)
        search.query = WeatherSearchQuery(city, type)
        search.setOnWeatherSearchListener(object : WeatherSearch.OnWeatherSearchListener {
            override fun onWeatherLiveSearched(p0: LocalWeatherLiveResult?, p1: Int) {
                val liveResult = p0?.liveResult
                if (p1 == 1000 && liveResult != null) {
                    AmapKitPlugin.send(Kid.SEARCH, Bid.WEATHER_LIVE, 0, liveResult.toMap())
                } else {
                    AmapKitPlugin.send(Kid.SEARCH, Bid.WEATHER_LIVE, p1)
                }

            }

            override fun onWeatherForecastSearched(p0: LocalWeatherForecastResult?, p1: Int) {
                val forecastResult = p0?.forecastResult
                if (p1 == 1000 && forecastResult != null) {
                    AmapKitPlugin.send(Kid.SEARCH, Bid.WEATHER_FORECAST, 0, forecastResult.toMap())
                } else {
                    AmapKitPlugin.send(Kid.SEARCH, Bid.WEATHER_FORECAST, p1)
                }
            }
        })
        search.searchWeatherAsyn()
    }
}