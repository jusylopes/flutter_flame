import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flame/blocs/bluetooth/bluetooth_cubit.dart';
import 'package:flutter_flame/blocs/bluetooth/bluetooth_state.dart';
import 'package:flutter_flame/utils/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bluetoothCubit = context.read<BluetoothCubit>();
    bluetoothCubit.requestPermissions().then((_) {
      bluetoothCubit.connectToDevice(AppStrings.bluetoothConnectionAddress);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: BlocBuilder<BluetoothCubit, BluetoothState>(
        builder: (context, state) {
          if (state.isConnecting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(state.statusMessage),
                ],
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.receivedData,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),
                Text(state.statusMessage),
              ],
            ),
          );
        },
      ),
    );
  }
}
