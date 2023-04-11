import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:setup_provider/application/main_controller.dart';
import 'package:setup_provider/presentation/view/pages/home/home_page.dart';
import 'package:setup_provider/presentation/view/pages/notification/notification_page.dart';
import 'package:setup_provider/presentation/view/pages/profile/profile_page.dart';
import 'package:setup_provider/presentation/view/pages/search/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final mainController = Get.put(MainController());

  notificationPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((event) {
      debugPrint("FirebaseMessaging.onMessage");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      debugPrint("FirebaseMessaging.onMessageOpenedApp");
    });
  }

  @override
  void initState() {
    notificationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainController>(builder: (controller) {
        return ProsteIndexedStack(
          index: controller.currentIndex,
          children: [
            IndexedStackChild(child: const HomePage()),
            IndexedStackChild(child: const SearchPage()),
            IndexedStackChild(child: const NotificationPage()),
            IndexedStackChild(child: const ProfilePage()),
          ],
        );
      }),
      bottomNavigationBar:
      GetBuilder<MainController>(builder: (controller){
        return BottomNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: (index) {
            controller.changeIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: "Notification"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ],
        );
      }),
    );
  }
}
