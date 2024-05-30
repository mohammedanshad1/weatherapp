import 'package:flutter/material.dart';
import 'package:weatherapp/weather_app/screens/home_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationPage extends StatefulWidget {
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  TextEditingController _searchController = TextEditingController();

  Future<List<String>> fetchCitySuggestions(String query) async {
    final String apiKey = '40228e3078cc75c6b9ac266d59da9fec'; // Replace with your OpenWeatherMap API key
    final String apiUrl = 'http://api.openweathermap.org/data/2.5/find?q=$query&type=like&sort=population&cnt=30&appid=$apiKey';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['list'];
        return data.map((item) => "${item['name']}, ${item['sys']['country']}")
            .toList();
      } else {
        return [];
      }

    }catch(e){
      return [];
    }
  }
  void navigateToHomePage(String city) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(city: city),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter Location',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return await fetchCitySuggestions(pattern);
              },
              itemBuilder: (context, String suggestion) {
                return ListTile(
                  title: Text(suggestion, style: TextStyle()),
                );
              },
              onSuggestionSelected: (String suggestion) {
                _searchController.text = suggestion;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                navigateToHomePage(_searchController.text);
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
