// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';
// import 'package:weatherapp/weather_app/constants/image_path.dart';
// import 'package:weatherapp/weather_app/services/location_provider.dart';
// import 'package:weatherapp/weather_app/services/weather_service_provider.dart';
// import 'package:intl/intl.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     final locationProvider =
//         Provider.of<LocationProvider>(context, listen: false);
//     locationProvider.determinePosition().then((_) {
//       if (locationProvider.currentLocationname != null) {
//         var city = locationProvider.currentLocationname!.locality.toString();
//         if (city != null) {
//           Provider.of<WeatherServiceProvider>(context, listen: false)
//               .fetchWeatherDataByCity(city);
//         }
//       }
//     });
//
//     // Provider.of<LocationProvider>(context,listen: false).determinePosition();
//     // Provider.of<WeatherServiceProvider>(context,listen: false).fetchWeatherDataByCity("Dubai");
//
//     super.initState();
//   }
//  TextEditingController _cityController=TextEditingController();
//
//   @override
//   void dispose(){
//
//     _cityController.dispose();
//     super.dispose();
//   }
//   bool _clicked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final locationProvider = Provider.of<LocationProvider>(context);
//     final weatherProvider = Provider.of<WeatherServiceProvider>(context);
//
//     // Get the sunrise timestamp from the API response
//     int sunriseTimestamp = weatherProvider.weather?.sys?.sunrise ?? 0; // Replace 0 with a default timestamp if needed
//     int sunsetTimestamp = weatherProvider.weather?.sys?.sunset ?? 0; // Replace 0 with a default timestamp if needed
//
// // Convert the timestamp to a DateTime object
//     DateTime sunriseDateTime = DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
//     DateTime sunsetDateTime = DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);
//
// // Format the sunrise time as a string
//     String formattedSunrise = DateFormat.Hm().format(sunriseDateTime);
//     String formattedSunset = DateFormat.Hm().format(sunsetDateTime);
//
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(),
//       body: Container(
//         padding: EdgeInsets.only(top: 90, left: 20, right: 20, bottom: 20),
//         height: size.height,
//         width: size.width,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               fit: BoxFit.cover,
//               image: AssetImage(background[
//                       weatherProvider.weather?.weather![0].main ?? "N/A"] ??
//                   "assets/img/weatherbackgroundimage.jpg")),
//         ),
//         child: Stack(
//
//           children: [
//             _clicked == true
//                 ? Positioned(
//                     top: 50,
//                     left: 20,
//                     right: 20,
//                     child: Container(
//                       height: 45,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: TextFormField(controller: _cityController,
//                                   decoration: InputDecoration(hintText: "Search City",
//                                       enabledBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(color: Colors.white)),
//                                       focusedBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(color: Colors.white))),
//                             ),
//                           ),
//                           IconButton(onPressed: (){
//
//                             Provider.of<WeatherServiceProvider>(context, listen: false).fetchWeatherDataByCity(_cityController.text.toString());
//                           }, icon: Icon(Icons.search)),
//                         ],
//                       ),
//
//
//                     ),
//                   )
//                 : SizedBox.shrink(),
//             Container(
//               height: 50,
//               child: Consumer<LocationProvider>(
//                   builder: (context, locationProvider, child) {
//                 var locationCity;
//                 if (locationProvider.currentLocationname != null) {
//                   locationCity =
//                       locationProvider.currentLocationname!.locality.toString();
//                 } else {
//                   locationCity = "Unknown location";
//                 }
//
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.location_pin,
//                             color: Colors.red,
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 locationCity.isEmpty
//                                     ? "unknown location"
//                                     : locationCity,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 18),
//                               ),
//                               Text(
//                                 "Good Morning",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//
//                     IconButton(
//                         onPressed: () {
//                           setState(() {
//                             _clicked = !_clicked;
//                           });
//                         },
//                         icon: Icon(Icons.search, size: 32))
//                   ],
//                 );
//               }),
//             ),
//             Align(
//                 alignment: Alignment(0, -0.6),
//                 child: Image.asset(
//                   imagePath[
//                           weatherProvider.weather!.weather![0].main ?? "N/A"] ??
//                       "assets/img/contrast.png",
//                   height: 130,
//                   width: 130,
//                 )),
//             Align(
//               alignment: Alignment(0, 0),
//               child: Container(
//                 height: 150,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "${weatherProvider.weather!.main!.temp?.toStringAsFixed(0)}\u00B0 C",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 32),
//                     ),
//                     Text(
//                       weatherProvider.weather!.name ?? "N/A",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 22),
//                     ),
//                     Text(
//                       weatherProvider.weather!.weather![0].main ??"N/A",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize:20),
//                     ),
//
//                     Text(
//                       DateFormat("hh:mm a").format(DateTime.now()),
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment(0.0, 0.75),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.4),
//                     borderRadius: BorderRadius.circular(20)),
//                 height: 180,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(children: [
//                           Image.asset(
//                             "assets/img/temperature.png",
//                             height: 55,
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Temp Max",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 "${weatherProvider.weather!.main!.tempMax!.toStringAsFixed(0)}\u00b0 C"??"N/A",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600),
//                               )
//                             ],
//                           ),
//                         ]),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Row(children: [
//                           Image.asset(
//                             "assets/img/low-temperature (1).png",
//                             height: 55,
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                           "Temp min",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                   "${weatherProvider.weather!.main!.tempMin!.toStringAsFixed(0)}\u00b0 C"??"N/A",
//
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600),
//                               )
//                             ],
//                           ),
//                         ]),
//                       ],
//                     ),
//                     Divider(
//                       color: Colors.white,
//                       thickness: 3.0, // Set a suitable thickness
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(children: [
//                           Image.asset(
//                             imagePath["Clear"],
//                             height: 55,
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                "Sunrise",
//
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 formattedSunrise,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600),
//                               )
//                             ],
//                           ),
//                         ]),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Row(children: [
//                           Image.asset(
//                             "assets/img/moon.png",
//                             height: 55,
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Sunset",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 "${formattedSunset}PM",
//
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600),
//                               )
//                             ],
//                           ),
//                         ]),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/image_path.dart';
import '../services/location_provider.dart';
import '../services/weather_service_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    locationProvider.determinePosition().then((_) {
      if (locationProvider.currentLocationname != null) {
        var city = locationProvider.currentLocationname!.locality;
        if (city != null) {
          Provider.of<WeatherServiceProvider>(context, listen: false).fetchWeatherDataByCity(city.toString());
        }
      }
    });

    super.initState();
  }
  TextEditingController _cityController=TextEditingController();
  bool _clicked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final locationProvider = Provider.of<LocationProvider>(context);

    // Get the weather data from the WeatherServiceProvider
    final weatherProvider = Provider.of<WeatherServiceProvider>(context);
// Inside the build method of your _HomePageState class

// Get the sunrise timestamp from the API response
    int sunriseTimestamp = weatherProvider.weather?.sys?.sunrise ?? 0; // Replace 0 with a default timestamp if needed
    int sunsetTimestamp = weatherProvider.weather?.sys?.sunset ?? 0; // Replace 0 with a default timestamp if needed

// Convert the timestamp to a DateTime object
    DateTime sunriseDateTime = DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
    DateTime sunsetDateTime = DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);

// Format the sunrise time as a string
    String formattedSunrise = DateFormat.Hm().format(sunriseDateTime);
    String formattedSunset = DateFormat.Hm().format(sunsetDateTime);
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 65, left: 20, right: 20, bottom: 20),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage( background[weatherProvider.weather?.weather![0]?.main ?? "N/A"] ?? "assets/img/weatherbackgroundimage.jpg",))),
        child: Stack(
          children: [

            Container(
              height: 50,
              child: Consumer<LocationProvider>(
                  builder: (context, locationProvider, child) {
                    var locationCity;
                    if (locationProvider.currentLocationname != null) {
                      locationCity = locationProvider.currentLocationname!.locality;
                    } else {
                      locationCity = "Unknown Location";
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(locationCity,style: TextStyle(
                                    color: Colors.white,fontWeight:FontWeight.w600, fontSize: 18,
                                  ),),
                                  Text(
                                     "Good Morning",style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    );
                  }),
            ),
            Align(
              alignment: Alignment(0, -0.7),
              child: Image.asset(
                imagePath[weatherProvider.weather?.clouds ?? "N/A"] ?? "assets/img/cloudy.png",height: 170,width: 170,
                // Adjust the height as needed
              ),),
            Align(
              alignment: Alignment(0, 0),
              child: Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                       "${weatherProvider.weather?.main?.temp?.toStringAsFixed(0)} \u00B0C" ?? "", 
                      // Display temperature
                      style:TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),),
                    Text(
                      weatherProvider.weather?.name ?? "N/A",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),),
                    Text(
                      weatherProvider.weather?.weather![0].main ?? "N/A",
                      style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),),
                    Text(
                       DateFormat('hh:mm a').format(DateTime.now()),
                      style: TextStyle(
                      color: Colors.white,
                    )),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.75),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.4)),
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
                                   "Temp Max",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),),
                                Text(
                                  "${weatherProvider.weather?.main!.tempMax!.toStringAsFixed(0)} \u00B0C"?? "N/A",
                                 style: TextStyle( color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
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
                                  "Temp Min",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),),
                                Text(
                                  "${weatherProvider.weather?.main!.tempMin!.toStringAsFixed(0)} \u00B0C"?? "N/A",
                                  style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14, fontWeight: FontWeight.w600,
                                )),
                              ],
                            )
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
                                  "Sunrise",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),),
                                Text(
                                  "${formattedSunrise} AM",
                                  style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
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
                                   "Sunset",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),),
                                Text(
                                  "${formattedSunset} PM",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Container(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _cityController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){
                      Provider.of<WeatherServiceProvider>(context, listen: false).fetchWeatherDataByCity(_cityController.text.toString());
                    }, icon: Icon(Icons.search))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}