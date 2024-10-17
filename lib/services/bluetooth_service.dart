import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:flutter_flame/utils/app_strings.dart';

abstract class BluetoothPlugin {
  Future<BluetoothConnection> connect({required String address});
}

class BluetoothPluginImp implements BluetoothPlugin {
  final FlutterBlueClassic _flutterBlueClassic = FlutterBlueClassic();

  @override
  Future<BluetoothConnection> connect({required String address}) async {
    BluetoothConnection? connection =
        await _flutterBlueClassic.connect(address);

    if (connection == null) {
      throw Exception(AppStrings.connectionFailure);
    }

    return connection;
  }
}
