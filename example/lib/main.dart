// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:amap_kit/amap_kit.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ak = 'ZwS8trYICIwuHuSfZ63ptHH27KNldd2L';
  final mcode =
      '6D:FE:E1:3A:BC:BB:FA:A7:D4:4D:B4:87:28:83:9D:56:15:13:AE:5D:B7:CD:3B:0B:61:42:1A:4D:BB:0C:FE:F5;com.yuro.amap_kit_example';

  bool? _init;
  int? locaitonId;

  void setApiKey() async {
    final init =
        await AmapKit().setApiKey(android: 'f182caf3ac5249c34b39d928509c46dd', ios: '76681ad42085d19ce7384c9ef04f059b');
    setState(() {
      _init = init;
    });
  }

  void startLocation() async {
    if (Platform.isAndroid && !await Permission.locationWhenInUse.request().isGranted) {
      return;
    }
    locaitonId = await AmapKit().location.startLocation(
        locationOptions: LocationOptions(isOnceLocation: false),
        onChanged: (code, location) {
          print('$code');
          print('${location?.toJson()}');
        });
    print(locaitonId);
  }

  void stopLocation() async {
    if (locaitonId != null) AmapKit().location.stopLocation(locaitonId!);
  }

  void liveWeather() async {
    AmapKit().search.liveWeather(
        city: '成都',
        onChanged: (code, weather) {
          print('$code,${weather?.toJson()}');
        });
  }

  void forecastWeather() async {
    AmapKit().search.forecastWeather(
        city: 'a',
        onChanged: (code, weather) {
          print('$code,${weather?.toJson()}');
        });
  }

  void checkNativeMaps() async {
    final result = await AmapKit().tool.checkNativeMaps();
    print(result.toJson());
  }

  void calculateLineDistance() async {
    const ll1 = LatLng(lng: 104.066811, lat: 30.657635);
    const ll2 = LatLng(lng: 104.166811, lat: 30.957635);
    final result = await AmapKit().tool.calculateLineDistance(ll1, ll2);
    print(result);
  }

  void coordinateConvert() async {
    const ll1 = LatLng(lng: 104.066811, lat: 30.657635);
    final result = await AmapKit().tool.coordinateConvert(ll1, CoordType.baidu);
    print(result?.toJson());
  }

  void amapNav() {
    AmapKit().navigate.amapNav(src: 'com.yuro.amap_kit_example', target: LatLng(lng: 104.066811, lat: 30.657635));
  }

  void bmapNav() {
    AmapKit().navigate.bmapNav(
          ak: ak,
          mcode: mcode,
          src: 'com.yuro.amap_kit_example',
          target: const LatLng(lng: 104.066811, lat: 30.657635),
        );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Amap_kit')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: setApiKey, child: Text('初始化ApiKey: $_init')),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(onPressed: startLocation, child: const Text('启动定位')),
            ElevatedButton(onPressed: stopLocation, child: const Text('停止定位')),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(onPressed: liveWeather, child: const Text('实时天气')),
            ElevatedButton(onPressed: forecastWeather, child: const Text('天气预报')),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(onPressed: checkNativeMaps, child: const Text('地图检查')),
            ElevatedButton(onPressed: calculateLineDistance, child: const Text('距离计算')),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(onPressed: amapNav, child: const Text('高德导航')),
            ElevatedButton(onPressed: bmapNav, child: const Text('百度导航')),
          ]),
          ElevatedButton(onPressed: coordinateConvert, child: const Text('坐标转换')),
        ],
      ));
}
