import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flame/blocs/bluetooth/bluetooth_cubit.dart';
import 'package:flutter_flame/blocs/bluetooth/bluetooth_state.dart';
import 'package:flutter_flame/utils/app_strings.dart';
import 'package:flutter_flame/utils/assets_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bluetoothCubit = context.read<BluetoothCubit>();
    bluetoothCubit.requestPermissions().then((_) {
      bluetoothCubit.connectToDevice(AppStrings.bluetoothConnectionAddress);
    });

    return Scaffold(
      body: Stack(
        children: [
          const CloudBackground(),
          BlocBuilder<BluetoothCubit, BluetoothState>(
            builder: (context, state) {
              final isFireDetected = state.receivedData == "1";

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

              return Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AssetsManager.imageTreeGif),
                  Image.asset(
                    isFireDetected
                        ? AssetsManager.imageEyesFlame
                        : AssetsManager.imageEyes,
                  ),
                  if (isFireDetected) Image.asset(AssetsManager.imageFlameGif),
                  Column(
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: Text(
                          isFireDetected
                              ? "Fogo detectado"
                              : "Tudo certo por aqui!",
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppStrings.appFontFamily,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (isFireDetected)
                        const Text(
                          "Ligar para 193, urgente!",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class CloudBackground extends StatelessWidget {
  const CloudBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Transform.scale(
            scale: 1.5,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topRight,
                widthFactor: 0.7,
                child: Image.asset(AssetsManager.imageCloud),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Align(
          alignment: Alignment.topRight,
          child: ClipRect(
            child: Align(
              alignment: Alignment.topLeft,
              widthFactor: 0.5,
              child: Image.asset(AssetsManager.imageCloud),
            ),
          ),
        ),
      ],
    );
  }
}
