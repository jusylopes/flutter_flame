import 'package:flutter_flame/services/notification_service.dart';
import 'package:workmanager/workmanager.dart';

abstract class BackgroundService {
  void connect(
      {required String task, required Map<String, dynamic>? inputData});
}

class BackgroundServiceImpl implements BackgroundService {
  @override
  void connect(
      {required String task, required Map<String, dynamic>? inputData}) {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

    Workmanager().registerPeriodicTask(
      task,
      "Bluetooth Monitoring Task",
      frequency: const Duration(minutes: 15),
      inputData: inputData,
    );
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final notificationService = NotificationServiceImpl();
    await notificationService.initialize();

    final String? receivedData = inputData?['receivedData'];
    if (receivedData == "1") {
      await notificationService.showFireDetectedNotification();
    }
    return Future.value(true);
  });
}
