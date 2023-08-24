import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mate_cli/services/location.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  Future<void> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    await getData(latitude: location.latitude, longitude: location.longitude);
  }

  Future<void> getData({required double latitude, required double  longitude}) async {
    String apiKey = dotenv.get('API_KEY');

    final apiUrl = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey');

    Response response = await get(apiUrl);

    print(response.body);
  }
}
