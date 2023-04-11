


import 'package:get/get.dart';

class MainController extends GetxController{

  int currentIndex = 0;

  changeIndex(int index)  {
    currentIndex = index;
    update();
  }

}