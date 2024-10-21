import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  final String place;
  const Result(
      {super.key,
      required this.place}); //melakukan instance dan mengirim data place

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Future<Map<String, dynamic>> getDataFromAPI() async {
    //add async
    //bertipe future untuk hit api
    final response = await http.get(
      //add await
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=${widget.place}&appid=1fe5f03e8b679377cbc41601289edfdd&units=metric"),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data;
    } else {
      throw Exception("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: const Text(
                "Hasil Tracking",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context); //context adalah screen ini
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.yellow,
                ),
              ) //seperti eventlistener di web
              ),
          body: Container(
            padding: EdgeInsets.only(left: 70, right: 70),
            child: FutureBuilder(
                future: getDataFromAPI(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image: NetworkImage(
                                  'https://flagsapi.com/${data["sys"]["country"]}/shiny/64.png')), //network image untuk ambil dari eksternal image
                          Text(
                            "Suhu: ${data["main"]["feels_like"]} C",
                            style: const TextStyle(fontSize: 25),
                          ),
                          Text(
                            'Kecepatan Angin : ${data["wind"]["speed"]} m/s',
                            style: const TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    );
                    // return Text(
                    //   data["weather"][0]["main"],
                    //   style: const TextStyle(fontSize: 25),
                    // ); //karena api data wheather bertipe array dan object, maka yang mesti dilakukan adalah melakukan indexing
                  } else {
                    return const Text("Tempat tidak ditemukan");
                  }
                }), //data yang ditunggu bertipe future dan render data dari api,
          )),
    );
  }
}
