# amap_kit

> ios配置

+ 增加权限,详见高德[权限配置](https://lbs.amap.com/api/ios-location-sdk/guide/create-project/permission-description)
```
	<key>NSLocationTemporaryUsageDescriptionDictionary</key>
	<dict>
        <key>ExampleUsageDescription</key>
        <string>This app needs accurate location so it can verify that you are in a supported region.</string>
        <key>AnotherUsageDescription</key>
        <string>This app needs accurate location so it can show you relevant results.</string>
    </dict>
	<key>NSLocationAlwaysUsageDescription</key>
	<string></string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string></string>
	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string></string>
```
注: ios11以后同时配置`NSLocationWhenInUseUsageDescription`、`NSLocationAlwaysAndWhenInUseUsageDescription`,
勾选权限`Capabilities -> UIBackgroundModes > Location updates`

+ 判断地图是否安装

```
    <key>LSApplicationQueriesSchemes</key>
    <array>
    <string>baidumap</string>
    <string>iosamap</string>
    </array>
```