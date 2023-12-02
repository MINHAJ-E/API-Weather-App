import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wether_app/controller/location_provider.dart';
import 'package:wether_app/controller/wether_services_provider.dart';
import 'package:wether_app/utils/methods.dart';

class HomeScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider.determinePosition().then((_) {
      if (locationProvider.currentLocationname != null) {
        var city = locationProvider.currentLocationname!.locality;
        if (city != null) {
          Provider.of<WetherServicesProvider>(context, listen: false)
              .fetchWeatherDataByCity(city.toString());
        }
      }
    });

    // Provider.of<LocationProvider>(context,listen: false).determinePosition();
    // Provider.of<WetherServicesProvider>(context,listen: false).fetchWeatherDataByCity("MALAPPURAM");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wetherprovider = Provider.of<WetherServicesProvider>(context);

    int sunriseTimestamp = wetherprovider.weather?.sys?.sunrise ??
        0; // Replace 0 with a default timestamp if needed
    int sunsetTimestamp = wetherprovider.weather?.sys?.sunset ??
        0; // Replace 0 with a default timestamp if needed

// Convert the timestamp to a DateTime object
    DateTime sunriseDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
    DateTime sunsetDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);
    TextEditingController citycontroller = TextEditingController();
// Format the sunrise time as a string
    String formattedSunrise = DateFormat.Hm().format(sunriseDateTime);
    String formattedSunset = DateFormat.Hm().format(sunsetDateTime);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgsnow.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Positioned(
                      child: Container(
                        height: 70,
                        color: Colors.black12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/location_pin.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Consumer<LocationProvider>(
                              builder: (context, locationProvider, child) =>
                                  Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  HaiText(
                                    textt:
                                        locationProvider.currentLocationname !=
                                                null
                                            ? locationProvider
                                                    .currentLocationname!
                                                    .locality ??
                                                "Unknown Locality"
                                            : "Unknown Locality",
                                    sizze: 15,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  HaiText(textt: "Good Morning", sizze: 13),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: citycontroller,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      // controller: ,
                                      decoration: const InputDecoration(
                                        hintText: "Search by city",
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      wetherprovider.fetchWeatherDataByCity(
                                          citycontroller.text);
                                    },
                                    icon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Positioned(
                      // bottom: 100,
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/weathersuncloud-removebg-preview.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Positioned(
                      // bottom: 100,
                      child: Container(
                        height: 160,
                        width: 200,
                        // color: Colors.black38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black38,
                        ),
                        child: Column(
                          children: [
                            HaiText(
                                textt:
                                    "${wetherprovider.weather?.main!.tempMin!.toStringAsFixed(0)} \u00B0C" ??
                                        "N/A",
                                sizze: 50),
                            SizedBox(
                              height: 10,
                            ),
                            HaiText(
                                textt: wetherprovider.weather!.name.toString(),
                                sizze: 25),
                            HaiText(
                                textt: wetherprovider.weather!.weather![0].main
                                    .toString(),
                                sizze: 23),
                            HaiText(
                                textt: DateFormat('hh:mm a')
                                    .format(DateTime.now()),
                                sizze: 15),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Positioned(
                      // bottom: 100,
                      child: Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black38,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50,
                                  width: 100,
                                  // color: Colors.black12,
                                  child: Row(
                                    children: [
                                      HaiPicture(
                                          picture:
                                              "assets/images/temprature_red3.png"),
                                      Column(
                                        children: [
                                          HaiText(textt: "TempMax", sizze: 15),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          HaiText(
                                            textt:
                                                "${wetherprovider.weather!.main!.tempMax!.toStringAsFixed(0)} \u00B0C" ??
                                                    "N/A",
                                            sizze: 13,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 100,
                                  // color: Colors.black12,
                                  child: Row(
                                    children: [
                                      HaiPicture(
                                          picture:
                                              "assets/images/temprature_blue.png"),
                                      Column(
                                        children: [
                                          HaiText(textt: "TempMin", sizze: 15),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          HaiText(
                                              textt:
                                                  "${wetherprovider.weather!.main!.tempMin!.toStringAsFixed(0)} \u00B0C" ??
                                                      "N/A",
                                              sizze: 13)
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const Divider(
                              height: 40,
                              color: Colors.white,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50,
                                  width: 100,
                                  // color: Colors.black12,
                                  child: Row(
                                    children: [
                                      HaiPicture(
                                          picture:
                                              "assets/images/sun-sunrise.png"),
                                      Column(
                                        children: [
                                          HaiText(textt: "Sun Rise", sizze: 15),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          HaiText(
                                              textt: "${formattedSunrise} AM",
                                              sizze: 13)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 100,
                                  // color: Colors.black12,
                                  child: Row(
                                    children: [
                                      HaiPicture(
                                          picture:
                                              "assets/images/moon2-removebg-preview.png"),
                                      Column(
                                        children: [
                                          HaiText(textt: "Sun Set", sizze: 15),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          HaiText(
                                              textt: "${formattedSunset} PM",
                                              sizze: 12),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
