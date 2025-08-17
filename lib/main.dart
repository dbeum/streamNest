import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:stream_nest/features/home/model/like_model.dart';
import 'package:stream_nest/features/home/model/pause_model.dart';
import 'package:stream_nest/features/home/model/video_model.dart';
import 'package:stream_nest/features/home/view/home_view.dart';
import 'package:stream_nest/nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LikeModel()),
        ChangeNotifierProvider(create: (_) => pauseModel()),
      ],
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
        brightness: Brightness.light,
        useMaterial3: true,

        primarySwatch: Colors.green,
        textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
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
