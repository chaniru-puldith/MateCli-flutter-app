import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mate_cli/screens/loading_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF1a1300),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF1a1300),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFc68c53),
        ),
      ),
      home: const LoadingScreen(),
    );
  }
}
