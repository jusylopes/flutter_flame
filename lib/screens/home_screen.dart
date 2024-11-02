import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flame/blocs/bluetooth/bluetooth_cubit.dart';
import 'package:flutter_flame/blocs/bluetooth/bluetooth_state.dart';
import 'package:flutter_flame/utils/app_colors.dart';
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
          Image.asset(AssetsManager.imageCloud),
          BlocBuilder<BluetoothCubit, BluetoothState>(
            builder: (context, state) {
              final bool isFireDetected = state.receivedData == "1";

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
                        height: 160,
                      ),
                      SizedBox(
                        width: 260,
                        child: Column(
                          children: [
                            Text(
                              isFireDetected
                                  ? "fogo detectado"
                                  : "tudo certo por aqui!",
                              style: const TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppStrings.appFontFamily,
                                color: Colors.black,
                                height: 0.75,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            if (isFireDetected)
                              RichText(
                                text: const TextSpan(
                                  text: 'ligar para 193, urgente!',
                                  style: TextStyle(
                                    fontSize: 30,
                                    backgroundColor: AppColors.flameColor,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
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
