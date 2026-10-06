import 'package:flutter/material.dart';
import '../features/url_input/presentation/url_input_screen.dart';

class WebSparkTest extends StatelessWidget {
  const WebSparkTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const UrlInputScreen(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
      ),
    );
  }
}
