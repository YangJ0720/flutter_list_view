import 'dart:async';

import 'package:flutter/material.dart';

class RevokeQueue {
  Timer _timer;

  void delay(VoidCallback callback) {
    //
    cancel();
    //
    _timer = Timer(Duration(seconds: 3), () {
      print('timer -> ${DateTime.now()}');
      callback.call();
    });
  }

  void cancel() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
  }
}
