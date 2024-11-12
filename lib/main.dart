import 'package:flutter/material.dart';
import 'package:flutter_flame/flame_app.dart';
import 'package:flutter_flame/services/background_service.dart';
import 'package:flutter_flame/services/notification_service.dart';
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

  runApp(const FlameApp());
}
