import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flame/blocs/bluetooth/bluetooth_cubit.dart';
import 'package:flutter_flame/blocs/bluetooth/bluetooth_state.dart';
import 'package:flutter_flame/utils/app_strings.dart';
import 'package:flutter_flame/utils/assets_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Center(
        child: Stack(
          children: [
            Image.asset(AssetsManager.imageCloud),
            BlocBuilder<BluetoothCubit, BluetoothState>(
              builder: (context, state) {
                final bool isFireDetected = state.receivedData == "1";

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
                  alignment: Alignment.center,
                  children: [
                    Image.asset(AssetsManager.imageTreeGif),
                    Image.asset(
                      isFireDetected
                          ? AssetsManager.imageEyesFlame
                          : AssetsManager.imageEyes,
                    ),
                    if (isFireDetected)
                      Image.asset(AssetsManager.imageFlameGif),
                    Column(
                      children: [
                        const SizedBox(
                          height: 160,
                        ),
                        SizedBox(
                          width: 260,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isFireDetected
                                    ? "fogo detectado"
                                    : "tudo certo por aqui!",
                                style: const TextStyle(
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
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
