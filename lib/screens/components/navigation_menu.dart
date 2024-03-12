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
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 15,
          )
        ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: NavigationBar(
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
      body: pages[currentIndex],
    );
  }
}