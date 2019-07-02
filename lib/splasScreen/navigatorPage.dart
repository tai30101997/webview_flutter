import 'package:flutter/material.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  static void goToqrPages(BuildContext context) {
    Navigator.pushNamed(context, "/qrpages");
  }

  static void goTowebview(BuildContext context) {
    Navigator.pushNamed(context, "/webview");
  }
}
