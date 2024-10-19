import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flame/blocs/bluetooth/bluetooth_cubit.dart';
import 'package:flutter_flame/screens/home_screen.dart';
import 'package:flutter_flame/services/bluetooth_service.dart';
import 'package:flutter_flame/utils/app_theme.dart';

class FlameApp extends StatelessWidget {
  const FlameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => BluetoothCubit(BluetoothPluginImp())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
