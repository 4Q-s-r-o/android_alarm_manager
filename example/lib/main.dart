// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/widgets.dart';

class HelloMessage {
  final DateTime _now;
  final String _msg;
  final int _isolate;

  HelloMessage(this._now, this._msg, this._isolate);

  @override
  String toString() {
    return "[$_now] $_msg "
        "isolate=$_isolate ";
  }
}

void greet() {
  print(new HelloMessage(
    new DateTime.now(),
    "Hello, world!",
    Isolate.current.hashCode,
  ));
}

Future<Null> main() async {
  runApp(const Center(child: Text('Hello, world!', textDirection: TextDirection.ltr)));

  final int helloAlarmID = 0;
  await AndroidAlarmManager.initialize();
  await AndroidAlarmManager.periodic(const Duration(seconds: 5), helloAlarmID, greet, wakeup: true);
}
