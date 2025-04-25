import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/Worker/worker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    print("init state");
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("set state");
  }
  @override
  Widget build(BuildContext context) {
    Map<String,dynamic>? info = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>? ??{};
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Activity"),
      ),
      body: 
          Column(
            children: <Widget>[
      FloatingActionButton (
        onPressed: () {},
      ),
              Text(info ["temp_value"]),
              Text(info ["hum_value"]),
               Text(info ["main_value"])
         ]
          )
    );
  }
}
