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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  ),
                ],
              ),
              const Divider(),
              StreamBuilder(
                stream: VolumedeckFlutter.volumeDeckEventStream,
                initialData: null,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  Map<String, dynamic>? data = snapshot.data;
                  return data == null
                      ? const SizedBox()
                      : Column(
                          children: data.entries.map((e) {
                            return ListTile(
                              title: Text(e.key),
                              trailing: Text(e.value?.toString() ?? ""),
                            );
                          }).toList(),
                        );
                },
              ),
            ],
          )),
    );
  }
}
