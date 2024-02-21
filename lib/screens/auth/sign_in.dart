import 'package:flutter/material.dart';
import 'package:heamed/screens/auth/sign_up.dart';
import 'package:heamed/screens/home/home.dart';
import 'package:heamed/widgets/form_container_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container( 
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration( 
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png')
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                SizedBox(height: 5,),
                Text("HEAMED", style: TextStyle(
                  fontSize: 40,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w900,
                ),),
                SizedBox(height: 45,),
                FormContainerWidget(
                  hintText: "email",
                  isPasswordField: false,
                ),
                SizedBox(height: 10,),
                FormContainerWidget(
                  hintText: "jelszó",
                  isPasswordField: true,
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home() ));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center( child: Text("Bejelentkezés", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),),
                  ),
                ),
                SizedBox(height: 15),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    Text("Nincs fiókod?"),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage() ));
                      },
                      child: Text("Regisztrálj",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ]),
              ],
            ),
          ),
        ),
      ), 
    );
  }
}