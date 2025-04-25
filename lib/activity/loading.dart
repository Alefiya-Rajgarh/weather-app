import 'package:flutter/material.dart';
import 'package:weather_app/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late String temp;
  late String hum;
  late String airspeed;
  late String des;
  late String main;

  void startApp() async {
    worker instance = worker(location: "indore");
    await instance.getData();
    temp = instance.temp;
    hum = instance.humidity;
    airspeed = instance.airSpeed;
    des = instance.description;
    main = instance.main;
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp,
        "hum_value": hum,
        "airspeed_value": airspeed,
        "des_value": des,
        "main_value": main
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("loading int state");
    startApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("images/weatherbg.jpg"),
    fit: BoxFit.cover,
    alignment: Alignment.center,
        ),
    ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/weather_logo.png',
              height: 240,
              width: 240,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Weather App",
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
              fontFamily: "fonts/Roboto-BoldItalic.ttf"),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "By Alefiya",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
              fontFamily: "fonts/Roboto-MediumItalic.ttf"),
            ),
            SizedBox(
              height: 30,
            ),
            SpinKitWave(
              color: Colors.blueAccent,
              size: 50.0,
            )
          ],
        ),
      ),
      )
    );
  }
}
