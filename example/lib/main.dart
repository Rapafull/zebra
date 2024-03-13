import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:zebra/zebra.dart';
import 'package:zebra_example/ScreenSettings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _zebraPlugin = Zebra();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _zebraPlugin.getPlatformVersion() ?? 'Unknown platform version';

      _zebraPlugin.getPrinterInstance(
 onPrinterDiscoveryDone: onPrinterDiscoveryDone,
        onPermissionDenied: onPermissionDenied,
        onChangePrinterStatus: onChangePrinterStatus,
        onDiscoveryError: onDiscoveryError,
        onPrinterFound: onPrinterFound

      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Function onPrinterDiscoveryDone = () {
    print("Discovery Done");
  };

  void onDiscoveryError (int i, String error) {
    print("Discovery Done");
  }

  void onPrinterFound (String msg1, String msg,bool mg) {
    print("Discovery Done");
  }

  void onChangePrinterStatus (status, color) {
    print("change printer status: " + status + color);
  }

  Function onPermissionDenied = () {
    print("Permission Deny.");
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ScreenSettings()
      ),
    );
  }
}
