// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sized_box_for_whitespace, file_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:whether/model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var text = TextEditingController();
  var TT = "";

  var image = "123";
  var title = " ";
  var temp = 0;
  var Abbr = "";
  var weoid = 0;

  GetCity(String City) async {
    var url = "https://www.metaweather.com/api/location/search/?query=$City";
    var jsondata = await http.get(Uri.parse(url));
    var jsonbody = jsonDecode(jsondata.body)[0];
    setState(() {
      title = jsonbody["title"];
      weoid = jsonbody["woeid"];
    });
  }

  Gettemp() async {
    var url = "https://www.metaweather.com/api/location/$weoid/";
    var jsondata = await http.get(Uri.parse(url));
    var jsonbody = jsonDecode(jsondata.body)["consolidated_weather"][0];
    setState(() {
      temp = jsonbody["the_temp"].round();
      image = jsonbody["weather_state_name"].replaceAll(' ', '').toLowerCase();
      Abbr = jsonbody["weather_state_abbr"];
    });
  }

  Future<List<Model>> Getcard() async {
    var url = "https://www.metaweather.com/api/location/$weoid/";
    List<Model> All = [];
    var jsondata = await http.get(Uri.parse(url));
    var jsonbody = jsonDecode(jsondata.body)["consolidated_weather"];
    print("Rsdsd $jsonbody");
    for (var i in jsonbody) {
      Model X = Model.fromjson(i);
      All.add(X);
    }
    return All;
  }

  Future<void> all() async {
    await GetCity(TT);
    await Gettemp();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/images/$image.png"), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height /5,
                  ),
                     Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Weather(150.0),
                        Text(
                          "$temp°C ",
                          style: TextStyle(fontSize: 60),
                        ),
                         SizedBox(
                          height:  MediaQuery.of(context).size.height /60,
                        ),
                        Text(
                          title,
                          style: const TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height:  MediaQuery.of(context).size.height /8,
                        ),
                      ],
                    ),
                  SizedBox(
                    height:  MediaQuery.of(context).size.height /500,
                  ),
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(
                        child: TextFormField(
                          enabled: true,
                          onFieldSubmitted: (value) {

                            TT = value;
                            all();
                            Getcard();
                            print(Abbr);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              hintText: "Enter Your City",
                              labelText: "Search City",
                              hintStyle: TextStyle(fontSize: 20)),
                        ),
                      )),
                  SizedBox(
                    height:  MediaQuery.of(context).size.height /50,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height /4.5,
                    width: 500,
                    child: FutureBuilder(
                      future: Getcard(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return (snapshot.hasData)?
                          ListView.builder(
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  width:  MediaQuery.of(context).size.width /2.85,
                                  child:
                                Card(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.white12,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "${snapshot.data[index].applicable_date}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    WeatherCard(snapshot.data[index].weather_state_abbr , 70.0),
                                    Text(title),
                                     Text(
                                      "Min : ${snapshot.data[index].min_temp.round()}°C",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Max : ${snapshot.data[index].max_temp.round()}°C",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ));
                            },
                          ): Text("");
                        }
                    ),
                  ),

                ],
              ),
            )));
  }
 Widget Weather (hi){
   if(Abbr == "lc"){
  return  Lottie.asset(
      'lib/Json/Weather/Cloud.json',
      width: hi,
    );
   }
   else if (Abbr == "c") {
     return  Lottie.asset(
       'lib/Json/Weather/clear.json',
       width: hi
     );
     }
   else if (Abbr == "hc") {
     return  Lottie.asset(
         'lib/Json/Weather/Heaavy Cloud.json',
         width: hi
     );
   }
   else if (Abbr == "s") {
     return  Lottie.asset(
         'lib/Json/Weather/Shower.json',
         width: hi
     );
   }
   else if (Abbr == "sn") {
     return  Lottie.asset(
         'lib/Json/Weather/4793-weather-snow.json',
         width: hi
     );
   }
   else if (Abbr == "h") {
     return  Lottie.asset(
         'lib/Json/Weather/50662-hail.json',
         width: hi
     );
   }
   else if (Abbr == "hr") {
     return  Lottie.asset(
         'lib/Json/Weather/Shower.json',
         width: hi
     );
   }
   else if (Abbr == "lr") {
     return  Lottie.asset(
         'lib/Json/Weather/light-rain.json',
         width: hi
     );
   }
   else if (Abbr == "sl") {
     return  Lottie.asset(
         'lib/Json/Weather/sleet.json',
         width: hi
     );
   }
   else if (Abbr == "t") {
     return  Lottie.asset(
         'lib/Json/Weather/thunder storm.json',
         width: hi
     );
   }
   else {
     return  Container();
   }
  }

 Widget WeatherCard (AbBr , w){
   if(AbBr == "lc"){
  return  Lottie.asset(
      'lib/Json/Weather/Cloud.json',
      width: w,
    );
   }
   else if (AbBr == "c") {
     return  Lottie.asset(
       'lib/Json/Weather/clear.json',
       width: w
     );
     }
   else if (AbBr == "hc") {
     return  Lottie.asset(
         'lib/Json/Weather/Heaavy Cloud.json',
         width: w
     );
   }
   else if (AbBr == "s") {
     return  Lottie.asset(
         'lib/Json/Weather/Shower.json',
         width: w
     );
   }
   else if (AbBr == "sn") {
     return  Lottie.asset(
         'lib/Json/Weather/4793-weather-snow.json',
         width: w
     );
   }
   else if (AbBr == "h") {
     return  Lottie.asset(
         'lib/Json/Weather/50662-hail.json',
         width: w
     );
   }
   else if (AbBr == "hr") {
     return  Lottie.asset(
         'lib/Json/Weather/Shower.json',
         width: w
     );
   }
   else if (AbBr == "lr") {
     return  Lottie.asset(
         'lib/Json/Weather/light-rain.json',
         width: w
     );
   }
   else if (AbBr == "sl") {
     return  Lottie.asset(
         'lib/Json/Weather/sleet.json',
         width: w
     );
   }
   else if (Abbr == "t") {
     return  Lottie.asset(
         'lib/Json/Weather/thunder storm.json',
         width: w
     );
   }
   else {
     return  Container();
   }
  }
}