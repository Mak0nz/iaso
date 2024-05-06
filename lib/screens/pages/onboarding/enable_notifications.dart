import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/screens/components/navigation_menu.dart';

class EnableNotifications extends StatefulWidget {
  const EnableNotifications({super.key});

  @override
  State<EnableNotifications> createState() => _EnableNotificationsState();
}

class _EnableNotificationsState extends State<EnableNotifications> {
  String _buttonText = "értesítések engedélyezése"; 
 // Initial text
  Color _textColor = Colors.grey.shade400; 
 // Initial color
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(35),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.bell, applyTextScaling: true, size: 100,),
                SizedBox(height: 15,),
                Text("Értesítések engedélyezése?", style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 22,
                ),),
                SizedBox(height: 10,),
                Text("Értesítsen, ha a gyógyszerek hamarosan kifogynak.", style: TextStyle( 
                  fontSize: 20,
                ),),
                SizedBox(height: 15,),
                GestureDetector(
                  child: Text(_buttonText,
                    style: TextStyle(
                      color: _textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),
                  ),
                  onTap: () => _enableNotifications(),
                ),
                SizedBox(height: 40,),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.bottomRight,
        margin: const EdgeInsets.only(left: 20,right: 20,bottom: 12),
        child: GestureDetector(
          child: Text("Befejezés", style: TextStyle(color: Colors.blue.shade400, fontWeight: FontWeight.bold, fontSize: 22),),
          onTap:() => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavigationMenu()), (route) => false),
        ),
        
      ),
    );
  }

  // ignore: unused_element
  void _enableNotifications() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    setState(() {
      _buttonText = "Engedélyezve"; // Change text to "Enabled"
      _textColor = Colors.green; // Change color to green
    });
  } 
}