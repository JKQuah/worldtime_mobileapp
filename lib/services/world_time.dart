import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime{

  String location; //location name for UI
  String time; // time in that location
  String flag; //url to an asset of image
  String url; //location url for api endpoint
  bool isDayTime; //return day or night time

WorldTime({this.location, this.time, this.flag, this.url, this.isDayTime});

  Future<void> getTime() async {

    try{
      //make request from world_time_api
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get the properties from data
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //set Date Time object
      DateTime current = DateTime.parse(datetime);
      current = current.add(Duration(hours: int.parse(offset)));

      //set this.time property
      isDayTime = current.hour > 6 && current.hour < 12 ? true : false;
      time = DateFormat.jm().format(current);
    }
    catch (e){
      print('Error caught: $e');
      time = 'Time could not be found';
    }
  }
}

