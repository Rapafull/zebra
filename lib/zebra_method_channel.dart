import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:zebra/ZebraPrinter.dart';

import 'zebra_platform_interface.dart';

/// An implementation of [ZebraPlatform] that uses method channels.
class MethodChannelZebra extends ZebraPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('zebra');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }


@override
  Future<ZebraPrinter> getPrinterInstance(
      {Function(String name, String ipAddress, bool isWifi)? onPrinterFound,
        onPrinterDiscoveryDone,
        Function(int errorCode, String errorText)? onDiscoveryError,
        Function(String status, String color)? onChangePrinterStatus,
        onPermissionDenied}) async {
    String id =
    await methodChannel.invokeMethod("getInstance");
    ZebraPrinter printer = ZebraPrinter(id, onPrinterFound,
        onPrinterDiscoveryDone, onDiscoveryError, onChangePrinterStatus,
        onPermissionDenied: onPermissionDenied);
    return printer;
  }
}
