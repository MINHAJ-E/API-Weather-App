import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wether_app/controller/location_provider.dart';
import 'package:wether_app/controller/wether_services_provider.dart';
import 'package:wether_app/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {                               
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocationProvider(),),
        ChangeNotifierProvider(create: (context) => WetherServicesProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
