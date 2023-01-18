import 'package:flutter/material.dart';
import 'package:volumedeck_flutter/volumedeck_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Volumedeck'),
            centerTitle: true,
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  VolumedeckFlutter.start();
                },
                child: const Text("Start"),
              ),
              ElevatedButton(
                onPressed: () {
                  VolumedeckFlutter.stop();
                },
                child: const Text("Stop"),
              )
            ],
          )),
    );
  }
}
