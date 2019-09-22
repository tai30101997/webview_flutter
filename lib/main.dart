import 'package:flutter/material.dart';
import './QrcodeandBarcode/scannerCode.dart';
import 'package:flutter/services.dart';
import './splasScreen/splasScreen.dart';
import './webviewPages/webviewPages.dart';
import './QrcodeandBarcode/scannerCode.dart';
import 'package:share/share.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  var routes = <String, WidgetBuilder>{
    "/webview": (BuildContext context) => WebView(),
    "/qrpages": (BuildContext context) => ScannerPage(),
  };
//splasScreen => 3s => webviewPages =>Check url=>{qrcode , camera , web}=>done
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.greenAccent[300],
          backgroundColor: Color(0xFFf6f7f8),
        ),
        navigatorKey: navigatorKey,
        home: SplashScreen(),
        routes: routes);
  }
}
