import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/notification/notification_model.dart';

class NotificationsSettingsController extends GetxController {
  RxBool orderReadyAlerts = true.obs;
  RxBool vibrationAlerts = true.obs;
  RxBool flashlightAlerts = true.obs;
  final List<NotificationModel> notificationsList = [];

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    orderReadyAlerts.value = prefs.getBool('orderReadyAlerts') ?? true;
    vibrationAlerts.value = prefs.getBool('vibrationAlerts') ?? true;
    flashlightAlerts.value = prefs.getBool('flashlightAlerts') ?? true;
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('orderReadyAlerts', orderReadyAlerts.value);
    prefs.setBool('vibrationAlerts', vibrationAlerts.value);
    prefs.setBool('flashlightAlerts', flashlightAlerts.value);
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
