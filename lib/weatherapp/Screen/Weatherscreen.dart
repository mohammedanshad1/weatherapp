import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:svg_flutter/svg.dart';
import 'package:weatherappproject/weatherapp/Screen/Settings.dart';

import '../widgets/weatherwidgets.dart';

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Weather App',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),


      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Weather App',style: TextStyle(color: Colors.white),
        ),actions: [IconButton(onPressed: (){

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Settings()));
      }, icon: Icon(Icons.search,size: 20,color: Colors.white,))
      ],
      ),
      body: Center(
        child: WeatherWidget(),
      ),
    );
  }
}
