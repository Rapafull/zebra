import 'package:zebra/ZebraPrinter.dart';

import 'zebra_platform_interface.dart';

class Zebra {
  Future<String?> getPlatformVersion() {
    return ZebraPlatform.instance.getPlatformVersion();
  }

  Future<ZebraPrinter> getPrinterInstance(
      {Function(String name, String ipAddress, bool isWifi)? onPrinterFound,
      onPrinterDiscoveryDone,
      Function(int errorCode, String errorText)? onDiscoveryError,
      Function(String status, String color)? onChangePrinterStatus,
      onPermissionDenied}) {
    return ZebraPlatform.instance.getPrinterInstance(
        onPrinterFound: onPrinterFound,
        onPrinterDiscoveryDone: onPrinterDiscoveryDone,
        onDiscoveryError: onDiscoveryError,
        onChangePrinterStatus: onChangePrinterStatus,
        onPermissionDenied: onPermissionDenied);
  }
}