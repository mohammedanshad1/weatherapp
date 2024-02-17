import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:svg_flutter/svg.dart';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {

  String imgurl="https://cdn.dribbble.com/users/925716/screenshots/3333720/attachments/722375/night.png";
  String _location = '';
  String _temperature = '';
  String _weatherCondition = '';
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String url =
          'https://api.openweathermap.org/data/2.5/weather?lat=11.24&lon=75.78&appid=ac0797a458f376e58b5fcf709618283f';
      http.Response response = await http.get(Uri.parse(url));
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _location = '${data['name']}, ${data['sys']['country']}';
        _temperature = '${data['main']['temp']}°C';
        _weatherCondition = data['weather'][0]['main'];
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching weather data';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Container(constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imgurl),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _loading
                      ? CircularProgressIndicator()
                      : Column(
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/weather_icons/weathericon.svg',
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 10),
                            Text(
                              _location,
                              style: TextStyle(fontSize: 35,color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _temperature,
                              style: TextStyle(fontSize: 30,color: Colors.white),
                            ),
                          ],
                        ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () => _fetchWeatherData(),
                    child: Text(
                      'Refresh',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            )));
  }
}
