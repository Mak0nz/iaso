import 'package:flutter/material.dart';
import 'package:iaso/widgets/appbar_widget.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: "Infó"),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 95,), // No content behind appbar on pageload.
              Text("Tudtad?", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container( 
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration( 
                          image: DecorationImage(
                            image: AssetImage('assets/Iaso.jpg')
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text("Iaso (Aszklépiosz lánya) a betegségekből való gyógyulás görög istennője volt."
                        , style: TextStyle(fontSize: 17),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}