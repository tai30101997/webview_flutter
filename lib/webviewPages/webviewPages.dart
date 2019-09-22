import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'dart:io';
import 'package:provider/provider.dart';
import './webview_bloc.dart';

class WebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Provider<WebviewBloc>.value(
      value: WebviewBloc(),
      child: Webviewpage(),
    ));
  }
}

class Webviewpage extends StatefulWidget {
  @override
  _WebviewpageState createState() => _WebviewpageState();
}

class _WebviewpageState extends State<Webviewpage> {
  String result = "";
  WebviewBloc webviewBloc = WebviewBloc();
  File _image;
  StreamSubscription<ConnectivityResult> streamConnectionStatus;
  StreamSubscription<bool> _listenQRcode;
  bool boolHasConnection = true;
  var listStringUrl = [];
  TextEditingController controller = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  var urlString = "http://dev3.lifeplusloyalty.vn/promotion";
  var urlChange = "enter Url Here";
  @override
  void initState() {
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      print(wvs.type);
    });
    webviewBloc.listenPostMess();
    super.initState();
  }
  //launchUrl
  // void launchUrl(String urlString) {
  //   setState(() {
  //     if (boolHasConnection == true) {
  //       listStringUrl = urlString.split(":");
  //       print(listStringUrl);
  //       if (listStringUrl.length > 1) {
  //         switch (listStringUrl[0]) {
  //           case "camera":
  //             {
  //               openCamera(true);
  //             }
  //             break;
  //           case "qrcode":
  //             {
  //               Navigator.pushReplacementNamed(
  //                 context,
  //                 '/qrpages',
  //               );
  //             }
  //             break;
  //           case "popup":
  //             {
  //               flutterWebviewPlugin.reloadUrl("https://${listStringUrl[1]}");
  //             }
  //             break;

  //           case "share":
  //             {
  //               Share.share(listStringUrl[1]);
  //             }
  //             break;
  //         }
  //       }
  //     }
  //   });
  // }

  //listen connection

  void dispose() {
    try {
      streamConnectionStatus?.cancel();
      _listenQRcode?.cancel();
    } catch (exception, stackTrace) {
      print(exception.toString());
    } finally {
      super.dispose();
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    var bloc = Provider.of<WebviewBloc>(context);
    Provider.of<WebviewBloc>(context).getConnectionStatus();
    Provider.of<WebviewBloc>(context).listenPostMess();
    _listenQRcode =
        Provider.of<WebviewBloc>(context).boolHasQrCODE.stream.listen((onData) {
      if (onData) {
        Navigator.pushReplacementNamed(
          context,
          '/qrpages',
        );
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WebviewBloc>(
        builder: (context, bloc, child) => StreamBuilder<bool>(
              stream: bloc.boolHasConnection.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data) {
                    case true:
                      return WebviewScaffold(
                        url: urlString,
                        withZoom: false,
                        withLocalStorage: true,
                        withJavascript: true,
                        clearCache: true,
                        withLocalUrl: true,
                      );
                      break;
                    case false:
                      return Scaffold(
                        body: Container(
                          width: 400,
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
                      break;
                    default:
                      return Scaffold(
                        appBar: AppBar(
                          title: Text('webview'),
                        ),
                        body: Container(
                          width: 400,
                          child: Text('data IN DEFAULT'),
                        ),
                      );
                  }
                } else {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('webview'),
                    ),
                    body: Container(
                      width: 400,
                      child: Text('data in else'),
                    ),
                  );
                }
              },
            ));
  }
}
