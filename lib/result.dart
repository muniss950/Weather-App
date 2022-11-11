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
                  FutureBuilder(
                      future:apicall(city),
                      builder: (context,snapshot) {

                        if(snapshot.hasData){
                          return Column(
                              children:[
                            Text(snapshot.data['description'].toString()),
                            Text("${snapshot.data['temp'].toString()} K")
                              ]
                          );
                        }
                        else{
                          return CircularProgressIndicator();
                        }
                      }),

                ],
              ),
            )
          );

      }
}
Future  apicall(String city) async{
  final url=Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=12bd29b3a15de53b773e62b28a9d8ea2");
  final response=await http.get(url);
  print(response.body);
  final json =jsonDecode(response.body);
  print(json['weather'][0]['description']);
  final output={
    'description': json['weather'][0]['description'],
    'temp': json['main']['temp']

  };
  return output;
}