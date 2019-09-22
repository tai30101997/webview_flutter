import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:share/share.dart';

class WebviewBloc {
  BuildContext context;
  StreamSubscription<ConnectivityResult> streamConnectionStatus;
  StreamController<bool> boolHasConnection = StreamController<bool>();
  Stream<bool> get boolHasConnectionStream => boolHasConnection.stream;
  Stream<String> get urlStringStream => urlString.stream;
  StreamController<bool> boolHasQrCODE = StreamController<bool>();

  StreamController<String> urlString = StreamController<String>();

  var listStringUrl = [];
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  void launchUrl(urlStringdata) {
    listStringUrl = urlStringdata.split(":");
    print(listStringUrl);
    if (listStringUrl.length > 1) {
      print(listStringUrl[0]);
      switch (listStringUrl[0]) {
        case "camera":
          {
            openCamera(true);
            boolHasQrCODE.sink.add(false);
          }
          break;
        case "qrcode":
          {
            boolHasQrCODE.sink.add(true);
            // Navigator.pushReplacementNamed(
            //   context,
            //   '/qrpages',
            // );
          }
          break;
        case "popup":
          {
            flutterWebviewPlugin.reloadUrl("https://${listStringUrl[1]}");
            boolHasQrCODE.sink.add(false);
          }
          break;

        case "share":
          {
            Share.share(listStringUrl[1]);
            boolHasQrCODE.sink.add(false);
          }
          break;
      }
    }
  }

  Future openCamera(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
  }

  void listenPostMess() {
    flutterWebviewPlugin.onStateChanged.listen((state) async {
      if (state.type == WebViewState.finishLoad) {
        String script =
            'window.addEventListener("message", receiveMessage, false);' +
                'function receiveMessage(event) {Android.getPostMessage(event.data);}';
        flutterWebviewPlugin.evalJavascript(script);
        
      }
      flutterWebviewPlugin.lightningLinkStream.listen((message) {
        launchUrl(message);
      });
    });
  }

  Future<Null> getConnectionStatus() async {
    streamConnectionStatus = new Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        boolHasConnection.sink.add(true);
      } else {
        boolHasConnection.sink.add(false);
      }
    });
  }

  dispose() {
    streamConnectionStatus.cancel();
    boolHasConnection.close();
    urlString.close();
    boolHasQrCODE.close();
  }
}
