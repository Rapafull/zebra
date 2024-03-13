import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:zebra/ZebraPrinter.dart';

import 'zebra_method_channel.dart';

abstract class ZebraPlatform extends PlatformInterface {
  /// Constructs a ZebraPlatform.
  ZebraPlatform() : super(token: _token);

  static final Object _token = Object();

  static ZebraPlatform _instance = MethodChannelZebra();

  /// The default instance of [ZebraPlatform] to use.
  ///
  /// Defaults to [MethodChannelZebra].
  static ZebraPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ZebraPlatform] when
  /// they register themselves.
  static set instance(ZebraPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<ZebraPrinter> getPrinterInstance(
      {Function(String name, String ipAddress, bool isWifi)? onPrinterFound,
        onPrinterDiscoveryDone,
        Function(int errorCode, String errorText)? onDiscoveryError,
        Function(String status, String color)? onChangePrinterStatus,
        onPermissionDenied}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
