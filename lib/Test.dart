// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 350,
        width: 350,
        child:
      Lottie.asset(
          'lib/images/82130-radio.json',
        fit: BoxFit.cover
      ),),
    );
  }
}
