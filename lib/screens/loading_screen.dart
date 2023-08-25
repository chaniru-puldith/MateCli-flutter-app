import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mate_cli/services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: SpinKitWave(
            color: Color(0xFFAC7339),
            size: 40.0,
          ),
        ),
      backgroundColor: Color(0xFF1a1300),
    );
  }

  Future <void> getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var data = await weatherModel.getLocationWeather();

    var weatherData = data['weatherData'];
    var errorData = data['error'];

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context){
          return LocationScreen(
            locationWeather: weatherData,
            locationError: errorData,
          );
        }),
    );
    checkLocationEnabled(errorData);
  }

  void checkLocationEnabled(error) {
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFF734d26),
              borderRadius: BorderRadius.all(Radius.circular(10),),
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.error_outline,
                  size: 40,
                  color: Colors.red,
                ),
                const SizedBox(width: 10.0,),
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
