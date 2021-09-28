import 'package:amap_kit/amap_kit.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ak = 'ZwS8trYICIwuHuSfZ63ptHH27KNldd2L';
  final mcode =
      '6D:FE:E1:3A:BC:BB:FA:A7:D4:4D:B4:87:28:83:9D:56:15:13:AE:5D:B7:CD:3B:0B:61:42:1A:4D:BB:0C:FE:F5;com.yuro.amap_kit_example';

  void setApiKey() async {
    AmapKit().tool.setApiKey('f182caf3ac5249c34b39d928509c46dd', '');
  }

  void startLocation() async {
    if (await Permission.locationWhenInUse.request().isGranted) {
      AmapKit().location.startLocation(onChanged: (location) {
        print('${location.toJson()}');
      });
    }
  }

  void stopLocation() async {
    AmapKit().location.stopLocation();
  }

  void liveWeather() async {
    AmapKit().search.liveWeather(
        city: '成都',
        onChanged: (weather) {
          print('${weather.toJson()}');
        });
  }

  void forecastWeather() async {
    AmapKit().search.forecastWeather(
        city: '成都',
        onChanged: (weather) {
          print('${weather.toJson()}');
        });
  }

  void checkNativeMaps() async {
    final result = await AmapKit().nav.checkNativeMaps();
    print(result.toJson());
  }

  void amapNav() {
    AmapKit().nav.amapNav(src: 'com.yuro.amap_kit_example', target: LatLng(104.066811, 30.657635));
  }

  void bmapNav() {
    AmapKit().nav.bmapNav(
          ak: ak,
          mcode: mcode,
          src: 'com.yuro.amap_kit_example',
          target: LatLng(104.066811, 30.657635),
        );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('Amap_kit')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          ElevatedButton(onPressed: setApiKey, child: Text('初始化ApiKey')),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(onPressed: startLocation, child: Text('启动定位')),
            ElevatedButton(onPressed: stopLocation, child: Text('停止定位')),
          ]),
          ElevatedButton(onPressed: liveWeather, child: Text('实时天气')),
          ElevatedButton(onPressed: forecastWeather, child: Text('天气预报')),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(onPressed: checkNativeMaps, child: Text('地图检查')),
            ElevatedButton(onPressed: amapNav, child: Text('高德导航')),
            ElevatedButton(onPressed: bmapNav, child: Text('百度导航')),
          ]),
        ]),
      ));
}
