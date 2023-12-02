import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wether_app/model/wether_model.dart';
import 'package:wether_app/secrets/api.dart';
import 'package:http/http.dart'as http;


class WetherServicesProvider extends ChangeNotifier{

  WetherModel?_weather;
  WetherModel? get weather=>_weather;

  bool _isLoading=false;
  bool? get isLoading=>_isLoading;

  String? _error;
  String? get error=>_error;


  Future<void>fetchWeatherDataByCity(String city)async{
    _isLoading=true;
    _error="";
//https://api.openweathermap.org/data/2.5/weather?q=MALAPPURAM&appid=07ed9a054a8933e91cc67f26e2354c44&units=metric

    try{
        final String  apiurl= "${APIEndPoints().cityurl}${city}&appid=${APIEndPoints().apikey}${APIEndPoints().unit}";
        print(apiurl);
        final response= await http.get(Uri.parse(apiurl));

        if(response.statusCode==200){
          final data=jsonDecode(response.body);
          print(data);

          _weather=WetherModel.fromJson(data);
          notifyListeners();
        }else{
          _error="Failed to lead data";
        }
    }catch(e){
      _error="Failed to lead data $e";
    }finally{
      _isLoading=false;
      notifyListeners();
    }

  }

}