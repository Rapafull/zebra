import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:zebra/ZebraPrinter.dart';
import 'package:zebra/zebra.dart';
import 'package:zebra/zebra_method_channel.dart';
import 'package:zebra/zebra_platform_interface.dart';

class MockZebraPlatform
    with MockPlatformInterfaceMixin
    implements ZebraPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<ZebraPrinter> getPrinterInstance(
      {Function(String name, String ipAddress, bool isWifi)? onPrinterFound,
      onPrinterDiscoveryDone,
      Function(int errorCode, String errorText)? onDiscoveryError,
      Function(String status, String color)? onChangePrinterStatus,
      onPermissionDenied}) {
    // TODO: implement getPrinterInstance
    throw UnimplementedError();
  }
}

void main() {
  final ZebraPlatform initialPlatform = ZebraPlatform.instance;

  test('$MethodChannelZebra is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelZebra>());
  });

  test('getPlatformVersion', () async {
    Zebra zebraPlugin = Zebra();
    MockZebraPlatform fakePlatform = MockZebraPlatform();
    ZebraPlatform.instance = fakePlatform;

    expect(await zebraPlugin.getPlatformVersion(), '42');
  });
}
