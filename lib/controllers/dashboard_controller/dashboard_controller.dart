import 'package:get/get.dart';

class DashboardController  extends GetxController{
  RxInt tabIndex = 0.obs;
  int get currentTab => tabIndex.value;
  void changeTabIndex(int newValue){
    tabIndex.value = newValue;
    update();
  }
}