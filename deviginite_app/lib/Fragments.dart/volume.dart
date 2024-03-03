import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_android_volume_keydown/flutter_android_volume_keydown.dart';

class VolumeApp extends StatefulWidget {
  const VolumeApp({Key? key}) : super(key: key);

  @override
  State<VolumeApp> createState() => _MyAppState();
}

class _MyAppState extends State<VolumeApp> {
  StreamSubscription<HardwareButton>? subscription;
  @override
  void initState() {
    super.initState();
  }

  void startListening() {
    subscription = FlutterAndroidVolumeKeydown.stream.listen((event) {
      print('');
      if (event == HardwareButton.volume_down) {
        print("Volume down received");
      } else if (event == HardwareButton.volume_up) {
        print("Volume up received");
      }
    });
  }

  void stopListening() {
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    print("S");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: startListening,
                  child: const Text("Start listening")),
              ElevatedButton(
                  onPressed: stopListening,
                  child: const Text("Stop listening")),
            ],
          ),
        ),
      ),
    );
  }
}
