import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zebra/ZebraPrinter.dart';
import 'package:zebra/zebra.dart';
import 'package:zebra_example/model_drivers.dart';

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
 State<ScreenSettings>  createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  ZebraPrinter? _zebraPrinter;
  List<ModelDrivers> _devices = [];
  ModelDrivers? _device;
  ModelDrivers? _deviceProvider;
  bool _connected = false;
  bool _sendConfigTypeMesa = true;
  bool _sendConfigTypePortatil = false;

  final _typePrinters = {"Portátil", "Mesa", "Sin configuración"};
  String? _typePrint = "Mesa";

  late String _configMesa;

  final _zebraPlugin = Zebra();

  late String _configPortatil;

  late String _zpl;

  @override
  void initState() {
    super.initState();
    _getZebra();
   // _getConfig();
    _zpl='''
    ^XA
    ^FO15,15^GFA,1488,1488,31,
    00000000000000000000000000000000000000000000000000000000000000
    00000000000000000000000000000000000000000000000000000000000000
    00000000000000000000000000000000000000000000000000000000000000
    00000E00000000000000000000000000000000000000000000000000000000
    00001F00000000000000000000000000000000000000000000000000000000
    00007FC0000000000000000000000000000000000000000000000000000000
    0001FFE0000000000000000000000000000000000000000000000000000000
    0000FFF0000000000000000000000000000000000000000000000000000000
    00003FF0000000000000000000000000000000000000000000000000000000
    00000FF0000000000000000000000000000000000000000000000000000000
    003003F8000000000000000000000000000000000000000000000000000000
    007001F8000000000000000000000000000000000000000000000000000000
    00F001F8000000000000000000000000000000000000000000000000000000
    01F000F8000000000000000000000000000000000000000000000000000000
    03F000F8000E0000001FE000003FC0038000F001FF8007FFFFC001FE000000
    03F000F8000F000000FFF80001FFF807C001F00FFFF807FFFFC00FFFC00000
    03F000F8000F000003FFFE0007FFFC03C001F01FFFFE07FFFFC01FFFF00000
    07F000F8000F000007FFFF000FFFFC03E003E03FFFFE07FFFFC07FFFF80000
    07F00078000F00000FE03F803FE03801F003E07F00FC0007C000FF01FC0000
    07F00078000F00001F800FC03F000001F007C07C00080007C000FC007E0000
    07F00078000F00003F0007E07E000000F80780F800000007C001F0003E0000
    07F00078000F00003E0003E07C000000F80F80F800000007C001F0001F0000
    07F00078000F00003C0001E0F80000007C0F00F800000007C003E0001F0000
    07F00078000F00007C0001F0F80000003C1F00FE0FF80007C003E0000F0000
    07F00078000F00007C0001F0F80000003E3E007FFFFE0007C003C0000F0000
    07F00078000F00007C0001F0F803FFC01E3C003FFFFF0007C003C0000F8000
    07F00078000F00007C0001F0F803FFE01F7C001FFFFF8007C003C0000F8000
    07F00078000F00007C0001F0F803FFE00FF80007FC3F8007C003C0000F0000
    07F00078000F00007C0001F0F80003E00FF80000000FC007C003E0000F0000
    07F00078000F00003C0001E0780003C007F000000007C007C003E0001F0000
    07F00078000F00003E0003E07C0003C003F000000007C007C001F0001F0000
    07F00078000F00001F0007E07E0007C003E0000000078007C001F8003E0000
    07F00078000F00001F800FC03F000F8001E000F0000F8007C000FC007E0000
    07F00078000F80000FE03F801FE03F8001E000FF003F8007C000FF03FC0000
    07F00078000FFFF807FFFF000FFFFE0001E000FFFFFF0007C0003FFFF80000
    07F00070000FFFFC03FFFE0007FFFC0001E0007FFFFC0007C0001FFFF00000
    07F00070000FFFF800FFF80001FFF80001E0000FFFF80003C00007FFC00000
    07F80070000FFFF8001FC000003FC00001C00000FF800003800001FE000000
    07F80070000000000000000000000000000000000000000000000000000000
    07FC0060000000000000000000000000000000000000000000000000000000
    07FE0000000000000000000000000000000000000000000000000000000000
    03FF0000000000000000000000000000000000000000000000000000000000
    03FFC000000000000000000000000000000000000000000000000000000000
    03FFFC00000000000000000000000000000000000000000000000000000000
    03FFFC00000000000000000000000000000000000000000000000000000000
    01FFFC00000000000000000000000000000000000000000000000000000000
    00FFF800000000000000000000000000000000000000000000000000000000
    007FF000000000000000000000000000000000000000000000000000000000
    ^FS
    ^FO370,20^A@N,80,80,E:tt0003m_.ttf^FD01^FS
    ^FO60,80^A@N,100,100,E:tt0003m_.ttf^FD1234^FS
    ^CFA,30
    ^FT1,185
    ^FB360,1,0,c
    ^FDABC_123^FS
    ^CFB,15
    ^FO20,215^FDwww.logysto.com^FS
    ^CFB,15
    ^FO180,215^FD03-01-2021 02:09 PM^FS
    ^FO360,85
    ^BQN,2.0,60^BQN,2,5^FDHM,N01234567^FS
    ^CFC,15
    ^FO365,210^FD01234567^FS
    ^XZ
    ''';
  }

  void _getZebra() async {
    print("get zebra");
    _zebraPrinter = await _zebraPlugin.getPrinterInstance(
        onPrinterFound: _onPrinterFound,
        onPrinterDiscoveryDone: _onPrinterDiscoveryDone,
        onPermissionDenied: _onPermissionDenied,
        onDiscoveryError: _onDiscoveryError,
        onChangePrinterStatus: _onChangePrinterStatus);

    _discoveryPrinters();
  }

  Future<void> _getConfig() async {
    _zpl = await rootBundle.loadString('assets/json/code_example.txt');
    _configMesa = await rootBundle.loadString('assets/json/config_mesa.txt');
    _configPortatil =
        await rootBundle.loadString('assets/json/config_portatil.txt');
  }

  void _onPrinterFound(name, ipAddress, isWifi) {
    print("PrinterFound :" + name + ipAddress);

    _devices.add(ModelDrivers(name: name, address: ipAddress));
    _device = _devices[0];

    setState(() {});
  }

  void _onPrinterDiscoveryDone() {
   print("Discovery Done");
  }

  void _onChangePrinterStatus(status, color) {
    print(
        "change printer status: " + status + color);
    print("onChangePrinterStatus $status $color");

    if (status == 'Connected') {
      _connected = true;

      if (_sendConfigTypeMesa) {
        debugPrint(_configMesa);
        _zebraPrinter?.print(_configMesa);
      }
      if(_sendConfigTypePortatil) {
          debugPrint(_configPortatil);
          _zebraPrinter?.print(_configPortatil);
        }
      setState(() {});
    }
  }

  void _onPermissionDenied() {
   print("Permission Deny.");
  }

  void _onDiscoveryError(code, state) {
   print("Discovery Error $code $state");
  }

  void _discoveryPrinters() {
    if (_zebraPrinter == null) {
     print(
           "Zebra sin instanciar");
      _getZebra();
    } else {
      _device = null;
      _devices = [];
      print( "Buscando dispositivos, por favor espere.",
         );
      _zebraPrinter?.discoveryPrinters();
    }
  }

  void printToast(String message) {
    print(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración impresora'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Dispositivo:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: DropdownButton<ModelDrivers>(
                      isExpanded: true,
                      items: _getDeviceItems(),
                      onChanged: (value) {
                        setState(() => _device = value);
                      },
                      value: _device,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Tipo impresora',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _typePrint,
                      items: _typePrinters.map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _typePrint = value;
                          if (_typePrinters.elementAt(0) == value) {
                            _sendConfigTypeMesa = false;
                            _sendConfigTypePortatil = true;
                          } else if (_typePrinters.elementAt(1) == value) {
                            _sendConfigTypeMesa = true;
                            _sendConfigTypePortatil = false;
                          } else {
                            _sendConfigTypeMesa = false;
                            _sendConfigTypePortatil = false;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child:Text("Actualizar"),
                      onPressed: _discoveryPrinters,
                      ),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      child: Text('Conectar'),

                      onPressed: () {


                          _connect();

                      },
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text( 'Descon'),

                      onPressed: () {


                          _disconnect();

                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              ElevatedButton(child: Text("Prueba de impresión"),  onPressed: (){_printTest();})

            ],
          ),
        ),
      ),
    );
  }

  void _connect() {
    final address = _device?.address ?? "";
    if (address.isNotEmpty) {
     print(
          'Conectando...${_device?.name} $address');
      _zebraPrinter?.connectToPrinter(address);
    } else {
     print(
          "Seleccione un dispositivo o active el BLUETOOTH");
    }
  }

  Future<void> _disconnect() async {
    await _zebraPrinter?.disconnect();
  }

  void _printTest() {

    print("print test");

    _zebraPrinter?.print(_zpl);
  }

  List<DropdownMenuItem<ModelDrivers>> _getDeviceItems() {
    final items = <DropdownMenuItem<ModelDrivers>>[];
    if (_devices.isEmpty) {
      items.add(const DropdownMenuItem(
        child: Text(
          'Vacío',
        ),
      ));
    } else {
      for (final device in _devices) {
        items.add(DropdownMenuItem(
          value: device,
          child: Text(
            device.name ?? '',
            style: const TextStyle(fontSize: 10),
          ),
        ));
      }
    }
    return items;
  }
}
