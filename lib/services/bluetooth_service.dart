import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:flutter_flame/utils/app_strings.dart';

abstract class BluetoothService {
  Future<BluetoothConnection> connect({required String address});
}

class BluetoothServiceImpl implements BluetoothService {
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
