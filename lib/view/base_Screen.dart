import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weter_app/model/constands.dart';
import 'package:weter_app/model/weather_model.dart';
import 'package:weter_app/services/authentication_service.dart';
import 'package:weter_app/view/loginscreen.dart';
import 'package:weter_app/widgets/button.dart';
import 'package:weter_app/widgets/text_feild.dart';

class BaseScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  const BaseScreen(
      {super.key, required this.latitude, required this.longitude});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  Map? map;
  String weather = '';
  String cityName = '';
  String countryName = '';
  double windspeed = 0;
  num visibility = 0;
  final cityContoller = TextEditingController();
  DateTime current_date = DateTime.now();
  @override
  void initState() {
    super.initState();
    curentMessege();
    Timer.periodic(
        const Duration(seconds: 1), (Timer t) => _getCurrentDateTime());
  }

  void _getCurrentDateTime() {
    setState(() {
      current_date = DateTime.now();
    });
  }

  String curentMessege() {
    if (current_date.hour <= 12) {
      return 'Good Moring';
    }
    if (current_date.hour > 12 && current_date.hour <= 14) {
      return 'Good After Noon';
    }
    if (current_date.hour > 14 && current_date.hour <= 19) {
      return 'Good evening ';
    }
    if (current_date.hour > 19 && current_date.hour <= 24) {
      return 'Good Night';
    }
    return 'Hey Guys';
  }

  String curentImage() {
    if (current_date.hour <= 12) {
      return kmoring;
    }
    if (current_date.hour > 12 && current_date.hour <= 14) {
      return kmainbaground;
    }
    if (current_date.hour > 14 && current_date.hour <= 19) {
      return kevening;
    }
    if (current_date.hour > 19 && current_date.hour <= 24) {
      return knight;
    }
    return 'Hey Gooys';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(curentImage()))),
            width: double.infinity,
            child: ListView(children: [
              Column(children: [
                khieght20,
                khieght30,
                Text(
                  curentMessege(),
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.amberAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${current_date.hour} : ${current_date.minute} : ${current_date.second}',
                  style: const TextStyle(
                    fontSize: 40,
                    color: kwhiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormFeilldWidets(cityContoller: cityContoller),
                ButtonWidets(
                    tasZ: () async {
                      final currentWeather = await WeatherModel.getCityWether(
                          cityName: cityContoller.text);
                      setState(() {
                        weather = currentWeather.weather.toString();
                        countryName = currentWeather.countryName!;
                        cityName = currentWeather.name!;
                        windspeed = currentWeather.windspeed!;
                        visibility = currentWeather.visibility!;
                      });
                    },
                    pic: Icons.search),
                khieght30,
                Text(
                  cityName,
                  style: const TextStyle(color: kwhiteColor, fontSize: 20),
                ),
                Text(
                  "${weather}℃",
                  style: const TextStyle(
                    fontSize: 50,
                    color: kwhiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                khieght20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text('Latitude',
                            style: TextStyle(fontSize: 15, color: kwhiteColor)),
                        khieght20,
                        Text(widget.latitude.toString(),
                            style: const TextStyle(
                                fontSize: 15, color: kwhiteColor)),
                      ],
                    ),
                    kwidth20,
                    Column(
                      children: [
                        const Text('Longitude',
                            style: TextStyle(fontSize: 15, color: kwhiteColor)),
                        khieght20,
                        Text(widget.longitude.toString(),
                            style: const TextStyle(
                                fontSize: 15, color: kwhiteColor)),
                      ],
                    )
                  ],
                ),
                Text(countryName,
                    style: const TextStyle(fontSize: 15, color: kwhiteColor)),
                Text(cityName,
                    style: const TextStyle(fontSize: 15, color: kwhiteColor)),
                khieght10,
                Text("Speed of Wind : ${windspeed.toString()}",
                    style: const TextStyle(fontSize: 17, color: kwhiteColor)),
                khieght10,
                Text("Visibility : ${visibility}",
                    style: const TextStyle(fontSize: 17, color: kwhiteColor)),
                khieght30,
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ButtonWidets(
                      tasZ: () async {
                        final currentWeather =
                            await WeatherModel.getCurentWether(
                                latitude: widget.latitude,
                                longitude: widget.longitude);

                        setState(() {
                          weather = currentWeather.weather.toString();
                          cityName = currentWeather.name!;
                          windspeed = currentWeather.windspeed!;
                          visibility = currentWeather.visibility!;
                          cityContoller.clear();
                        });
                      },
                      pic: Icons.location_on),
                  kwidth20,
                  ButtonWidets(
                      tasZ: () async {
                        await Authentication().signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false);
                      },
                      pic: Icons.logout)
                ])
              ])
            ])));
  }
}
