import 'package:flutter/material.dart';
import 'package:mate_cli/services/location.dart';
import 'package:mate_cli/services/networking.dart';
import 'package:mate_cli/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    return Scaffold(
        body: Center(
          child: SpinKitWave(
            color: Colors.white,
            size: 50.0,
          ),
        ),
    );
  }

  Future<void> getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    
    NetworkHelper networkHelper = NetworkHelper(url: 'https://api.openweathermap.org/data/2.5/weather?units=metric&lat=${location.latitude}&lon=${location.longitude}');

    var weatherData = networkHelper.getData();
    
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen();
    }));
  }
}
