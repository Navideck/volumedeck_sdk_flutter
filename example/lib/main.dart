// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  double mockSpeed = 0.0;
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
    var androidActivationKey =
        "on2aKTfiM49rTLylSV04gOpVRVLmZ3RQuJXeQRLCWCmunUbAS1fxcS6PpMNqTJmwgmANPB9Z5bDIIce-evrnTWvksYedUeXqRfjTCgouF08ATaSMlh47i0zOlwuVbESZ2a9UIj0a5jyDpX6ZhKsJGSgaGVPmvBa_Aj2bkGTE4VTf4VQZ49b3FiYcnCeL5kMSDemQxIwCX_a5uvbSF11LQoDEIF-GXAwwxUD9ev7FHUaKUyrZhr2RexPpchJ4G53ivyYITi0YSTmtVb5uN0sAvWwae09USyZZDoIn_B3regLCjgL1g5j_U2jaL5Kvba5QsgY1QqYR40Jt2NesCkP_krbx2kZ3eXe4nmZlpO5jAeGdcsCpd5AAn6q0HIKCVb0fi_ZD5C4FEjfVkwawwa6TH-V5BXddJM6Y8YEIf2mpqeagu-faPsEhunsaHvFF5eIx8JkH4AhzuucQAeVI_zMGiTfD6BBBzksKYfCvx7BlIKnRB6VAxvoXCkloeOh772Gu11D83sXf0jEHhXyd6Pps06Zdf5y5_cJIt46XC4Yl4g4Rt4qIj40pZfK19PeL2QCmhDfI6dSXBlm9czkPnSnzafDS2rOx1x7cz8Ci16KlgASbXoAjW7Xmh61eS5jlVFJoT8QDRdFJZOnNDBM5Noh-jA47t1BUb_Wd1M0NWjCvRzQ";
    var iOSActivationKey =
        "bsYZ-aE4j4HPLp4BiqY21s1mUsOvuqHKnaqSb__n9WEWm4QqXDG8sY2dhfds38XAOs_4jj_xFj464f586jy3EnXTc6RUrb_eVscIJGgKNcrGEJQlST5WGUZDbcE6bWKpcrjVIfphaiggvDTKqm9ahcs47E6OfHOeAf2t82rx0mVVqoeMjdEp5UrZk14H64db0ayljEfB_2oR7pRkx0GblIc96QC8KiylDiq0MKiXpDFVrTCchbxSz2Um0aAQPdsOP0un6UPspKoPTFu5CcCzWWe_iLIYxUVqdgpTWhgz2NyExoi7RwQJ70q2HpBMf_Cpy3qdZcdJj604NdzPy6YWiQyCT_rT_ZkbXiKZDBSutCSm9TPha1TKg466RfKLgrhYEDAW5XW4ooJRY9r4PR_-Ly39W-9Qh5TF-Jg6lzMfft5HH6qtp-JnmLIc4xw0HzPMb6QtwcB3F11NBudq5WsLt64kD6JGbnhEi3RE5PYTzGE0nOyQo3vGybas9SQl6XrEHGmgMjaW2om4qLIDsiKc1XYkjFKEFq6dSoYru0TfwhqescYbLW4Z2jN8WtlGpxvqwF8-eNHGVxH0YF2B-GhogTp_cxVx0jSs6TFblgSv7cwZmuMlAvyHx5CLsUuhXM0cE8nSshqxTHb9x1CJS0H5iocpYMefcHHpLN_GWc86N70";

    await Volumedeck.initialize(
      androidActivationKey: androidActivationKey,
      iOSActivationKey: iOSActivationKey,
      runInBackground: true,
      autoStart: false,
      androidConfig: AndroidConfig(
        notificationTitle: "Volumedeck is running in background",
        notificationStopButtonText: "Stop Volumedeck",
        showStopButtonInNotification: true,
        notificationSubtitle: "Speed -> %s m/s | Volume -> %s ",
        notificationIconDrawable: "notification_icon",
      ),
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
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text("Mock Speed"),
              ),
              Slider(
                min: 0,
                max: 50,
                value: mockSpeed,
                onChanged: (value) {
                  Volumedeck.setMockSpeed(value.toInt());
                  setState(() {
                    mockSpeed = value;
                  });
                },
              )
            ],
          )),
    );
  }
}
