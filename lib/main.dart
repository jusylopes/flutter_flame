import 'package:flutter/material.dart';
import 'package:flutter_flame/app.dart';
import 'package:flutter_flame/service/background_service.dart';
import 'package:flutter_flame/service/notification_service.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  NotificationService notificationService = NotificationServiceImpl();
  notificationService.initialize();

  final backgroundService = BackgroundServiceImpl();
  backgroundService.connect(
    task: "bluetoothMonitoringTask",
    inputData: {'receivedData': '1'},
  );

  runApp(const MyApp());
}
