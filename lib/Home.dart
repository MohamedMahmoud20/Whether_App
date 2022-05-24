import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:whether/Result.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.3),

      body: GestureDetector(
        onTap: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const Home();})),
        child: Center(
          child: Lottie.asset(
            'lib/Json/9318-globe.json',
          ),
        ),
      ),
    );
  }
}