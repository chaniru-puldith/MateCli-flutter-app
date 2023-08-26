import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper({required this.url});

  Future getData() async {
    String apiKey = dotenv.get('API_KEY');

    final apiUrl = Uri.parse('$url&appid=$apiKey');

    http.Response response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return -1;
    }
  }
}