/*
import 'package:flutter/gestures.dart';

import 'api/api.dart';

class AppClock {
  static int? _ntpBaseMillis; // NTP time in millis at app startup
  static final Stopwatch _stopwatch = Stopwatch()..start();

  /// Starts the clock by syncing with internet time
  static Future<void> init([bool reRun = false]) async {
    final ntp = await Api.getNtp();

    if (ntp == null) {
      // Retry later if failed
      if(reRun)Future.delayed(Duration(seconds: 5), init);
      return;
    }

    // _stopwatch.();
    _ntpBaseMillis = ntp.millisecondsSinceEpoch - millis;
  }

  /// Returns "internet-based current time" (unchangeable by user)
  static DateTime now() {
    if (_ntpBaseMillis == null) {
      return DateTime.now();
    }

    return DateTime.fromMillisecondsSinceEpoch(
      _ntpBaseMillis! + millis,
    );
  }

  static int get millis => _stopwatch.elapsedMilliseconds;
}
*/
