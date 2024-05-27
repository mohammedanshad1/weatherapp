import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/image_path.dart';
import '../services/location_provider.dart';
import '../services/weather_service_provider.dart';
import 'locationsearch.dart';

class HomePage extends StatefulWidget {
  final String? city;

  const HomePage({Key? key, this.city}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    if (widget.city != null && widget.city!.isNotEmpty) {
      // Fetch weather data for the provided city
      Provider.of<WeatherServiceProvider>(context, listen: false)
          .fetchWeatherDataByCity(widget.city!);
    } else {
      // Use current location if no city is provided
      final locationProvider =
      Provider.of<LocationProvider>(context, listen: false);
      locationProvider.determinePosition().then((_) {
        if (locationProvider.currentLocationname != null) {
          var city = locationProvider.currentLocationname!.locality;
          if (city != null) {
            Provider.of<WeatherServiceProvider>(context, listen: false)
                .fetchWeatherDataByCity(city.toString());
          }
        }
      });
    }
  }

  TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final locationProvider = Provider.of<LocationProvider>(context);
    final weatherProvider = Provider.of<WeatherServiceProvider>(context);

    int sunriseTimestamp = weatherProvider.weather?.sys?.sunrise ?? 0;
    int sunsetTimestamp = weatherProvider.weather?.sys?.sunset ?? 0;

    DateTime sunriseDateTime =
    DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
    DateTime sunsetDateTime =
    DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);

    String formattedSunrise = DateFormat.Hm().format(sunriseDateTime);
    String formattedSunset = DateFormat.Hm().format(sunsetDateTime);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 65, left: 20, right: 20, bottom: 20),
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                background[
                weatherProvider.weather?.weather![0]?.main ?? "N/A"] ??
                    "assets/img/weatherbackgroundimage.jpg",
              ),
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: 50,
                child: Consumer<LocationProvider>(
                  builder: (context, locationProvider, child) {
                    var locationCity =
                        widget.city ?? locationProvider.currentLocationname?.locality ?? "Unknown Location";

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                color: Colors.red,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LocationPage()),
                                  );
                                },
                                icon: Icon(Icons.location_pin),
                              ),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    locationCity,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "Good Morning",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment(0, -0.6),
                child: Image.asset(
                  imagePath[weatherProvider.weather?.clouds ?? "N/A"] ??
                      "assets/img/cloudy.png",
                  height: 170,
                  width: 170,
                ),
              ),
              Align(
                alignment: Alignment(0, -0.15),
                child: Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${weatherProvider.weather?.main?.temp?.toStringAsFixed(0)} \u00B0C" ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        weatherProvider.weather?.name ?? "N/A",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        weatherProvider.weather?.weather![0].main ?? "N/A",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(DateTime.now()),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.0, 0.60),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.4),
                  ),
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/img/temperature.png',
                                height: 55,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Temp Max",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${weatherProvider.weather?.main!.tempMax!.toStringAsFixed(0)} \u00B0C" ?? "N/A",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Row(
                            children: [
                              Image.asset(
                                'assets/img/low-temperature (1).png',
                                height: 55,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Temp Min",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${weatherProvider.weather?.main!.tempMin!.toStringAsFixed(0)} \u00B0C" ?? "N/A",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 3.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/img/sunny.png',
                                height: 55,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sunrise",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${formattedSunrise} AM",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Row(
                            children: [
                              Image.asset(
                                'assets/img/moon.png',
                                height: 55,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sunset",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${formattedSunset} PM",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   top: 50,
              //   left: 20,
              //   right: 20,
              //   child: Container(
              //     height: 45,
              //     child: Row(
              //       children: [
              //         Expanded(
              //           child: TextFormField(
              //             style: TextStyle(color: Colors.white),
              //             controller: _cityController,
              //             decoration: InputDecoration(
              //               enabledBorder: UnderlineInputBorder(
              //                 borderSide: BorderSide(color: Colors.white),
              //               ),
              //               focusedBorder: UnderlineInputBorder(
              //                 borderSide: BorderSide(color: Colors.white),
              //               ),
              //             ),
              //           ),
              //         ),
              //         IconButton(
              //           onPressed: () {
              //             Provider.of<WeatherServiceProvider>(context, listen: false)
              //                 .fetchWeatherDataByCity(_cityController.text.toString());
              //           },
              //           icon: Icon(Icons.search),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
