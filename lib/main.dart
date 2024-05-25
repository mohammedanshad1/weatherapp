import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/weather_app/screens/home_screen.dart';
import 'package:weatherapp/weather_app/services/location_provider.dart';
import 'package:weatherapp/weather_app/services/weather_service_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>LocationProvider()),
        ChangeNotifierProvider(create: (context)=>WeatherServiceProvider())

      ],
      child: MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(

        appBarTheme: AppBarTheme(color: Colors.transparent,),
          useMaterial3: true,iconTheme: IconThemeData(color: Colors.white)
        ),
        home: HomePage(),
      ),
    );
  }
}
