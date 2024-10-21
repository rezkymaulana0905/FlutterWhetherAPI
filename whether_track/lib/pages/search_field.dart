import 'package:flutter/material.dart';
import 'package:whether_track/pages/result.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController placeController = TextEditingController(); //controller
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Tracking Cuaca",
              style: TextStyle(color: Color.fromARGB(255, 25, 23, 23)),
            ),
            backgroundColor: const Color.fromARGB(255, 207, 228, 242),
            centerTitle: true,
          ),
          body: Center(
              child: Container(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: const InputDecoration(hintText: "ex: Jakarta"),
                  controller: placeController,
                ),
                const SizedBox(height: 25.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Result(place: placeController.text,);
                    })); //stack

                    print(placeController.text); //test input manual
                  },
                  child: const Text("Track"),
                )
              ],
            ),
          ))),
    );
  }
}
