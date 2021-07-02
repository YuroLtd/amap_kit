import 'package:amap_kit/amap_kit.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? locationId;
  var locationKit = LocationKit();

  Future<void> setApiKey() async {
    await AmapKit.setApiKey('f182caf3ac5249c34b39d928509c46dd', '');
  }

  void startLocation() async {
    if (await Permission.locationWhenInUse.request().isGranted) {
      locationId = await locationKit.startLocation(onChanged: (location, err) {
        print('${location?.toJson()},$err');
      });
    }
  }

  void stopLocation() async {
    if (locationId != null) locationKit.stopLocation(locationId!);
  }

  void weatherQuery() async {
    WeatherSearchKit().weatherSearch('成都', type: WeatherType.WEATHER_TYPE_LIVE, onChanged: (weather, err) {
      print('${weather?.toJson()}');
    });
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
          ElevatedButton(onPressed: weatherQuery, child: Text('查询天气')),
        ]),
      ));
}
