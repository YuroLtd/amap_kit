package com.yuro.amap_kit.src.plugin

import android.content.Context
import android.util.Log
import com.amap.api.services.weather.*
import com.yuro.amap_kit.AmapKitPlugin
import com.yuro.amap_kit.src.util.Bid
import com.yuro.amap_kit.src.util.Tid
import io.flutter.plugin.common.MethodCall

object SearchPlugin {

    /**
     * 获取天气数据
     */
    fun weatherSearch(context: Context, call: MethodCall) {
        val city = call.argument<String>("city")!!
        val type = call.argument<Int>("type") ?: 0
        val search = WeatherSearch(context)
        search.query = WeatherSearchQuery(city, type + 1)
        search.setOnWeatherSearchListener(object : WeatherSearch.OnWeatherSearchListener {
            override fun onWeatherLiveSearched(p0: LocalWeatherLiveResult?, p1: Int) {
                p0?.liveResult?.let {
                    AmapKitPlugin.sendSuccess(Tid.SEARCH, Bid.WEATHER_LIVE, it.toMap())
                }
            }

            override fun onWeatherForecastSearched(p0: LocalWeatherForecastResult?, p1: Int) {
                p0?.forecastResult?.let {
                    AmapKitPlugin.sendSuccess(Tid.SEARCH, Bid.WEATHER_FORECAST, it.toMap())
                }
            }
        })
        search.searchWeatherAsyn()
    }
}

fun LocalWeatherLive.toMap(): Map<String, Any> {
    return mapOf(
        "adCode" to adCode,
        "province" to province,
        "city" to city,
        "reportTime" to reportTime,
        "humidity" to humidity,
        "temperature" to temperature,
        "weather" to weather,
        "windDirection" to windDirection,
        "windPower" to windPower
    )
}

fun LocalWeatherForecast.toMap(): Map<String, Any> {
    return mapOf("adCode" to adCode,
        "province" to province,
        "city" to city,
        "reportTime" to reportTime,
        "forecasts" to weatherForecast.map {
            mapOf(
                "date" to it.date,
                "dayTemp" to it.dayTemp,
                "dayWeather" to it.dayWeather,
                "dayWindDirection" to it.dayWindDirection,
                "dayWindPower" to it.dayWindPower,
                "nightTemp" to it.nightTemp,
                "nightWeather" to it.nightWeather,
                "nightWindDirection" to it.nightWindDirection,
                "nightWindPower" to it.nightWindPower
            )
        }
    )
}