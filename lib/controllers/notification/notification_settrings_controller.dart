import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/notification/notification_model.dart';

class NotificationsSettingsController extends GetxController {
  final orderReadyAlerts = true.obs;
  final vibrationAlerts = true.obs;
  final flashlightAlerts = true.obs;
  final List<NotificationModel> notificationsList = [];

  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void _loadSettings() {
    orderReadyAlerts.value = storage.read('orderReadyAlerts') ?? true;
    vibrationAlerts.value = storage.read('vibrationAlerts') ?? true;
    flashlightAlerts.value = storage.read('flashlightAlerts') ?? true;
  }

  void _saveSettings() {
    storage.write('orderReadyAlerts', orderReadyAlerts.value);
    storage.write('vibrationAlerts', vibrationAlerts.value);
    storage.write('flashlightAlerts', flashlightAlerts.value);
  }

  void toggleOrderReadyAlerts(bool value) {
    orderReadyAlerts.value = value;
    _saveSettings();
  }

  void toggleVibrationAlerts(bool value) {
    vibrationAlerts.value = value;
    _saveSettings();
  }

  void toggleFlashlightAlerts(bool value) {
    flashlightAlerts.value = value;
    _saveSettings();
  }
}
