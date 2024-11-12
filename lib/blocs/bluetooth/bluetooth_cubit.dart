import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:flutter_flame/blocs/bluetooth/bluetooth_state.dart';
import 'package:flutter_flame/services/bluetooth_service.dart';
import 'package:flutter_flame/utils/app_strings.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothCubit extends Cubit<BluetoothState> {
  final BluetoothService _bluetoothPlugin;
  BluetoothConnection? _connection;

  BluetoothCubit(this._bluetoothPlugin) : super(BluetoothState.initial());

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.location,
    ].request();

    bool allPermissionsGranted =
        statuses.values.every((status) => status.isGranted);

    if (!allPermissionsGranted) {
      emit(state.copyWith(
        statusMessage: AppStrings.permissionsNotGranted,
        isConnecting: false,
      ));
      return;
    }
  }

  Future<void> connectToDevice(String deviceAddress) async {
    emit(state.copyWith(
        isConnecting: true, statusMessage: AppStrings.connectingMessage));

    try {
      _connection = await _bluetoothPlugin
          .connect(address: deviceAddress)
          .timeout(const Duration(minutes: 3), onTimeout: () {
        throw TimeoutException(AppStrings.timeoutError);
      });

      if (_connection != null && _connection!.isConnected) {
        emit(state.copyWith(
          statusMessage: AppStrings.pairingSuccess,
          isConnecting: false,
        ));

        _connection!.input!.listen((data) {
          emit(state.copyWith(
            receivedData: String.fromCharCodes(data),
          ));
        }, onError: (error) {
          emit(state.copyWith(
            statusMessage: AppStrings.receivedDataError + error.toString(),
            isConnecting: false,
          ));
        });
      }
    } catch (e) {
      emit(state.copyWith(
        receivedData: AppStrings.receivedDataError,
        statusMessage: e is TimeoutException
            ? AppStrings.timeoutError
            : AppStrings.connectionFailure,
        isConnecting: false,
      ));
    }
  }

  @override
  Future<void> close() {
    _connection?.dispose();
    return super.close();
  }
}
