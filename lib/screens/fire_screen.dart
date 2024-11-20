import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flame/blocs/bluetooth/bluetooth_cubit.dart';
import 'package:flutter_flame/blocs/bluetooth/bluetooth_state.dart';
import 'package:flutter_flame/utils/app_strings.dart';
import 'package:flutter_flame/utils/assets_manager.dart';
import 'package:rive/rive.dart' as rive;
import 'package:url_launcher/url_launcher.dart';

class FireScreen extends StatefulWidget {
  const FireScreen({super.key});

  @override
  State<FireScreen> createState() => _FireScreenState();
}

class _FireScreenState extends State<FireScreen> {
  @override
  void initState() {
    super.initState();
    final bluetoothCubit = context.read<BluetoothCubit>();
    bluetoothCubit.requestPermissions().then((_) {
      bluetoothCubit.connectToDevice(AppStrings.bluetoothConnectionAddress);
    });
  }

  Future<void> _makePhoneCall({required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          rive.RiveAnimation.asset(
            AssetsManager.animationTree,
            fit: BoxFit.cover,
          ),
          BlocBuilder<BluetoothCubit, BluetoothState>(
            builder: (context, state) {
              const bool isFireDetected = true;

              if (state.isConnecting) {
                return Column(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(state.statusMessage),
                  ],
                );
              }

              return Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  if (isFireDetected)
                    Image.asset(
                      AssetsManager.imageFlameGif,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 42,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 160,
                        ),
                        SizedBox(
                          width: 290,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                isFireDetected
                                    ? "fogo detectado"
                                    : "tudo certo por aqui!",
                                style: TextStyle(
                                  fontSize: 55,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppStrings.appFontFamily,
                                  color: Colors.black,
                                  height: 0.9,
                                ),
                              ),
                              if (isFireDetected)
                                GestureDetector(
                                  onTap: () =>
                                      _makePhoneCall(phoneNumber: '193'),
                                  child: const Text(
                                    "ligar para 193",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: AppStrings.appFontFamily,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
