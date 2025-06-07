import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/Worker/worker.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = new TextEditingController();
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
    Map<String, dynamic>? info =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    String icon = info['icon_value'];
    String hum = info['hum_value'];
    String des = info['des_value'];
    String air = ((info['airspeed_value']).toString()).substring(0, 4);
    String city_value = info['city_value'];

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    var city_name = ["Mumbai", "Indore", "Dhar", "London", "Delhi"];
    final random = new Random();
    var city = city_name[random.nextInt(city_name.length)];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Color(0xFFBBDEFB),
          )),
      body: SingleChildScrollView(
      child: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xFFBBDEFB),
              Colors.blue,
              Color(0xff0D47A1),
            ])),
        child: Column(
          children: [
            //search bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.034,
                  vertical: screenHeight * 0.0182),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(24)),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/loading", arguments:{
                          "searchedPlace": search.text,
                        });
                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.blue,
                        ),
                        margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                      )),
                  Expanded(
                      child: TextField(
                        controller: search,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Any City Name like $city"),
                  ))
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.034),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Image.network(
                              "https://openweathermap.org/img/wn/$icon@2x.png"),
                          SizedBox(
                            width: screenWidth * 0.09,
                          ),
                          Column(
                            children: [
                              Text(
                                "$des",
                                style: TextStyle(
                                    fontSize: screenHeight * 0.025,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "fonts/Roboto-ThinItalic.ttf"),
                              ),
                              Text(
                                "in $city_value",
                                style: TextStyle(
                                    fontSize: screenHeight * 0.025,
                                    fontFamily: "fonts/Roboto-ThinItalic.ttf"),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      height: screenHeight * 0.252,
                      margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.034,
                          vertical: screenHeight * 0.012),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(WeatherIcons.thermometer),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ((info['temp_value']).toString())
                                    .substring(0, 4),
                                style:
                                    TextStyle(fontSize: screenHeight * 0.0912),
                              ),
                              Text(
                                "C",
                                style:
                                    TextStyle(fontSize: screenHeight * 0.0512),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    height: screenHeight * 0.292,
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.034),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.day_windy),
                            SizedBox(width: 10,),
                            Text("Air Speed",
                              style: TextStyle(fontSize: screenHeight * 0.018),)
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Text(
                          "$air",
                          style: TextStyle(fontSize: screenHeight * 0.05),
                        ),
                        Text(
                          "km/hr",
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: screenHeight * 0.292,
                    margin: EdgeInsets.fromLTRB(1, 0, screenWidth * 0.034, 0),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Icon(WeatherIcons.humidity),
                            SizedBox(width: 10,),
                          Text ("Humidity",
                            style: TextStyle(fontSize: screenHeight * 0.018),)],
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Text(
                          "$hum",
                          style: TextStyle(fontSize: screenHeight * 0.05),
                        ),
                        Text(
                          "percent",
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "copyright ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: "fonts/Roboto-ThinItalic.ttf"),
                      ),
                      Icon(
                        Icons.copyright_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        " Alefiya",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: "fonts/Roboto-ThinItalic.ttf"),
                      ),
                    ],
                  ),
                  Text(
                    "~ Data Provided by OpenWeathermap.org",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontFamily: "fonts/Roboto-ThinItalic.ttf"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      ),
      )
    );
  }
}
