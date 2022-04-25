package com.yuro.amap_kit.util

import com.amap.api.services.weather.LocalWeatherForecast
import com.amap.api.services.weather.LocalWeatherLive

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