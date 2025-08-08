import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_nest/features/home/model/like_model.dart';
import 'package:stream_nest/features/home/view/home_view.dart';
import 'package:stream_nest/nav.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LikeModel())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light, // Light theme
        useMaterial3: true,
        // Define your light theme here
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black,
          ), // Text color for light mode
          // Add other text styles as needed
        ),
        // Other theme settings...
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Dark theme
        useMaterial3: true,

        primarySwatch: Colors.green,
        textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
      ),
      themeMode: ThemeMode.system,
      home: Nav(),
      debugShowCheckedModeBanner: false,
    );
  }
}
