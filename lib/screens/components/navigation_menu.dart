import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/screens/pages/home.dart';
import 'package:iaso/screens/pages/info.dart';
import 'package:iaso/screens/pages/meds/meds.dart';
import 'package:iaso/screens/pages/stats/stats.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentIndex = 0;
  List pages = const[
    Home(),
    StatsPage(),
    MedsPage(),
    InfoPage(),
  ];

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
        decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 20,
              spreadRadius: 10,
            )
          ],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade900.withAlpha(20), width: 2.0, style: BorderStyle.solid),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: NavigationBar(
              //backgroundColor: Colors.transparent,
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(icon: Icon(FontAwesomeIcons.house), label: 'főoldal'),
                NavigationDestination(icon: Icon(FontAwesomeIcons.heartCirclePlus), label: 'mérések'),
                NavigationDestination(icon: Icon(FontAwesomeIcons.capsules), label: 'gyógyszer'),
                NavigationDestination(icon: Icon(FontAwesomeIcons.circleInfo), label: 'infó'),
              ],
            ),
          ),
        ),
      ),
      body: pages[currentIndex],
    );
  }
}