import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mate_cli/screens/city_screen.dart';
import 'package:mate_cli/services/weather.dart';
import 'package:mate_cli/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final dynamic locationWeather;
  final dynamic locationError;

  const LocationScreen(
      {super.key, required this.locationWeather, this.locationError});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  late int temperature;
  late int condition;
  late String cityName;
  late String message;
  late String weatherIcon;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show a confirmation dialog to the user.
        bool shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: const Text('Exit'),
              ),
            ],
          ),
        );

        // If the user confirms, then exit the app.
        if (shouldExit) {
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1a1300),
            ),
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () async {
                          var data = await weatherModel.getLocationWeather();
                          var weatherData = data['weatherData'];
                          var errorData = data['error'];
                          updateUI(weatherData);
                          checkLocationEnabled(errorData);
                        },
                        child: const Icon(
                          Icons.my_location,
                          size: 50.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var enteredCityName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CityScreen();
                              },
                            ),
                          );

                          if (enteredCityName != null) {
                            var data = await weatherModel
                                .getCityWeather(enteredCityName);
                            var weatherData = data['weatherData'];
                            var errorData = data['error'];

                            errorData != -1 ? updateUI(weatherData) : {};
                            checkLocationEnabled(errorData);
                          }
                        },
                        child: const Icon(
                          Icons.travel_explore,
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          weatherIcon,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      '$message in $cityName!',
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      message = weatherModel.getMessage(temperature);
      weatherIcon = weatherModel.getWeatherIcon(condition);
    });
  }

  void checkLocationEnabled(dynamic error) {
    if (error != null) {
      if (error == -1) {
        error = 'City Not found';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFF734d26),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.error_outline,
                  size: 40,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Error",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        error,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    }
  }
}
