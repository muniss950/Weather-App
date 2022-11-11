import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class result extends StatelessWidget{

    final String city;
    result({required this.city});
        @override
        Widget build(BuildContext context){
          return Scaffold(
            appBar: AppBar(
              title: Text("Weather"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.blue,
              child:
              Column(children:[

                FutureBuilder(
                      future:apicall(city),
                      builder: (context,snapshot) {

                        if(snapshot.hasData){
                          return Column(
                              children:[
                            Text("City name: ${city}",
                            style: TextStyle(
                              color: Colors.white
                            ),),
                            Text("Country: ${snapshot.data["country"].toString()}",
                            style: TextStyle(
                              color: Colors.white
                            ),),
                            Text('Description: ${snapshot.data['description'].toString()}',
                            style: TextStyle(
                              color:Colors.white
                            ),),
                            Text("Temperature: ${snapshot.data['temp'].toString()}C",
                            style: TextStyle(
                              color: Colors.white
                            ),),
                            Text("Humidity: ${snapshot.data['humidity'].toString()}",
                            style: TextStyle(
                              color: Colors.white
                            ),) ,
                            Text("Wind Speed: ${snapshot.data['speed'].toString()}",
                            style: TextStyle(
                              color: Colors.white
                            ),),
                            Text("Visibility: ${snapshot.data['visibility'].toString()}",
                            style: TextStyle(
                              color: Colors.white
                            ),)
                              ]
                          );
                        }
                        else{
                          return CircularProgressIndicator();
                        }
                      }),
            ]
            )
            )
                ],
              ),
            )
          );

      }
}
Future  apicall(String city) async{
  final url=Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=12bd29b3a15de53b773e62b28a9d8ea2&units=metric");
  final response=await http.get(url);
  print(response.body);
  final json =jsonDecode(response.body);
  print(json['weather'][0]['description']);
  final output={
    'description': json['weather'][0]['description'],
    'temp': json['main']['temp'],
    'humidity': json['main']['humidity'],
    'pressure': json['main']['pressure'],
    'speed': json['wind']['speed'],
    'visibility': json['visibility'],
    'country': json['sys']['country']};
  return output;
}