// ignore_for_file: avoid_print

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
  late Volumedeck volumedeckFlutter;

  bool isLocationOn = false;
  bool isStarted = false;
  double speed = 0.0;
  double volume = 0.0;

  void initializeVolumedeck() {
    volumedeckFlutter = Volumedeck(
      runInBackground: false,
      onLocationStatusChange: (bool status) {
        setState(() => isLocationOn = status);
      },
      onStart: () {
        setState(() => isStarted = true);
      },
      onStop: () {
        setState(() => isStarted = false);
      },
      onLocationUpdate: (s, v) {
        setState(() {
          speed = s;
          volume = v;
        });
      },
    );
  }

  @override
  void initState() {
    initializeVolumedeck();
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
            leading: Icon(
              isLocationOn ? Icons.location_on : Icons.location_off,
            ),
            actions: [
              Icon(
                Icons.circle,
                color: isStarted ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 10)
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      volumedeckFlutter.start();
                    },
                    child: const Text("Start"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      volumedeckFlutter.stop();
                    },
                    child: const Text("Stop"),
                  ),
                ],
              ),
              const Divider(),
              ListTile(
                title: const Text("Speed"),
                trailing: Text(speed.toString()),
              ),
              ListTile(
                title: const Text("Volume"),
                trailing: Text(volume.toString()),
              )
            ],
          )),
    );
  }
}
