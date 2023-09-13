// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
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
  late Volumedeck volumedeck;

  bool isLocationOn = false;
  bool isStarted = false;
  double speed = 0.0;
  double volume = 0.0;

  Future<bool> hasPermissions() async {
    if (!Platform.isAndroid) return true;

    var locationPermission = await Permission.location.request();
    if (locationPermission.isDenied) return false;
    var notificationPermission = await Permission.notification.request();
    return notificationPermission.isGranted;
  }

  void initializeVolumedeck() async {
    if (!await hasPermissions()) {
      print("Failed to get permissions");
      return;
    }
    // Make sure to add .env file in the root of the project
    await dotenv.load(fileName: ".env");

    await Volumedeck.initialize(
      androidActivationKey: dotenv.env['ANDROID_ACTIVATION_KEY'],
      iOSActivationKey: dotenv.env['IOS_ACTIVATION_KEY'],
      runInBackground: true,
      autoStart: false,
      showStopButtonInAndroidNotification: true,
      showSpeedAndVolumeChangesInAndroidNotification: true,
      locationServicesStatusChange: (bool status) {
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
                    onPressed: () async {
                      try {
                        await Volumedeck.start();
                      } on PlatformException catch (e) {
                        print("Error: ${e.message}");
                      }
                    },
                    child: const Text("Start"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Volumedeck.stop();
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
