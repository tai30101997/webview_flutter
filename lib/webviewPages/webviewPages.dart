import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';

class Webviewpage extends StatefulWidget {
  @override
  _WebviewpageState createState() => _WebviewpageState();
}

class _WebviewpageState extends State<Webviewpage> {
  String result = "";
  File _image;
  StreamSubscription<ConnectivityResult> streamConnectionStatus;
  bool boolHasConnection = true;
  var listStringUrl = [];
  TextEditingController controller = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  var urlString = "https://www.google.com";
  var urlChange = "enter Url Here";
  @override
  void initState() {
    getConnectionStatus();
    launchUrl();
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      print(wvs.type);
    });
    super.initState();
  }

  //camera
  Future openCamera(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
  }

  //qrCode
  Future qrCode() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
    Navigator.pushReplacementNamed(context, '/qrpages', result: result);
  }

  //launchUrl
  void launchUrl() {
    setState(() {
      if (boolHasConnection == true) {
        listStringUrl = urlString.split(":");
        print(listStringUrl);
        if (listStringUrl.length > 1) {
          switch (listStringUrl[0]) {
            case "camera":
              {
                openCamera(true);
              }
              break;
            case "qrcode":
              {
                qrCode();
              }
              break;
          }
        }
        flutterWebviewPlugin.reloadUrl(urlString);
      }
    });
  }

  //listen connection
  Future<Null> getConnectionStatus() async {
    streamConnectionStatus = new Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          boolHasConnection = true;
        });
      } else {
        setState(() {
          boolHasConnection = false;
        });
      }
    });
  }

  void dispose() {
    try {
      streamConnectionStatus?.cancel();
    } catch (exception, stackTrace) {
      print(exception.toString());
    } finally {
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return boolHasConnection
        ? WebviewScaffold(
            // appBar: new AppBar(
            //   title: TextField(
            //     cursorColor: Colors.blueAccent,
            //     controller: controller,
            //     textInputAction: TextInputAction.go,
            //     onSubmitted: (urlString) => launchUrl(),
            //     style: TextStyle(color: Colors.white),
            //     decoration: InputDecoration(
            //       border: InputBorder.none,
            //       hintText: "${urlChange}",
            //       hintStyle: TextStyle(color: Colors.white),
            //     ),
            //     onChanged: (String urlString) {
            //       setState(() {
            //         urlString = urlChange;
            //       });
            //     },
            //   ),
            //   actions: <Widget>[
            //     IconButton(
            //         icon: Icon(Icons.navigate_next),
            //         onPressed: () {
            //           launchUrl();
            //         })
            //   ],
            // ),
            url: urlString,
            withZoom: false,
          )
        : Scaffold(
            body: Container(
              color: Colors.blueGrey[50],
              child: AlertDialog(
                title: new Text("InternetError"),
                content: new Text("Please check your internet"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
