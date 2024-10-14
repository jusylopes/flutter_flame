import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BluetoothConnection? connection;
  String dataReceived = 'Sem dados';

  @override
  void initState() {
    super.initState();
    connectToBluetooth();
  }

  void connectToBluetooth() async {
    try {
      connection = await BluetoothConnection.toAddress('21:13:ED9A');
      debugPrint('Conectado ao dispositivo Bluetooth');

      connection!.input!.listen((Uint8List data) {
        setState(() {
          dataReceived = String.fromCharCodes(data).trim();
        });
        debugPrint('Recebido: $dataReceived');
      }).onDone(() {
        debugPrint('Conexão encerrada.');
      });
    } catch (error) {
      debugPrint('Erro ao conectar: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Status: $dataReceived'),
        ElevatedButton(
          onPressed: () {
            connectToBluetooth();
          },
          child: const Text('Conectar ao Bluetooth'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    connection?.dispose();
    super.dispose();
  }
}
