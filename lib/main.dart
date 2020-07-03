import 'package:flutter/material.dart';
import 'package:kikbutton/circle_loading_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingCircleButton(
            buttonColor: Colors.pinkAccent,
            callback: () async {
                //dummy function
                await Future.delayed(Duration(seconds: 5));
            },
            minRadius: MediaQuery.of(context).size.width*0.5,
            maxRadius: MediaQuery.of(context).size.width*0.9,
        ),
      ),
    );
  }
}