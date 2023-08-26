import 'package:mate_cli/services/location.dart';
import 'package:mate_cli/services/networking.dart';

const openWeatherMapURL =
    'https://api.openweathermap.org/data/2.5/weather?units=metric';

class WeatherModel {
  Future<Map<String, dynamic>> getLocationWeather() async {
    Location location = Location();
    String? error = await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$openWeatherMapURL&lat=${location.latitude}&lon=${location.longitude}');

    var weatherData = await networkHelper.getData();

    return <String, dynamic>{'weatherData': weatherData, 'error': error};
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
