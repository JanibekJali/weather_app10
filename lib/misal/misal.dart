import 'dart:developer';

import 'package:flutter/material.dart';

class Misal extends StatefulWidget {
  const Misal({Key? key}) : super(key: key);

  @override
  _MisalState createState() => _MisalState();
}

class _MisalState extends State<Misal> {
  @override
  void initState() {
    log('Init State  ====> ');
    getText();
    super.initState();
  }

  String? text;
  Future<void> getText() async {
    log('GetText =====> ');
    await Future.delayed(const Duration(seconds: 4), () {
      text = 'Text keldi';
    });
    setState(() {});
    Map<String, dynamic> mapTur = {
      'key': 'value',
    };
  }

  @override
  Widget build(BuildContext context) {
    log('Build =====> ');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hello kandaisyn?',
              style: TextStyle(fontSize: 50),
            ),
            Text(
              text ?? 'Text kele elek',
              style: const TextStyle(fontSize: 50),
            ),
          ],
        ),
      ),
    );
  }
}
