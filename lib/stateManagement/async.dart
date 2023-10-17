import 'dart:async';
import 'package:dic/utils/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConditionNotifier extends ChangeNotifier {
  bool _isTokenExpired = false;

  bool get tokenExpired => _isTokenExpired;

  void condition(bool newCondition) {
    _isTokenExpired = newCondition;
    notifyListeners(); // Notify listeners when the condition changes
  }

  final StreamController<String> _conditionController =
      StreamController<String>.broadcast();

  ConditionNotifier() {
    // Create a Stream subscription to continuously check the condition
    final subscription = _conditionController.stream.listen((token) {
      String expiredTime = getJwtExpiredTime(token);
      Duration timeDifferences =
          DateTime.now().difference(DateTime.parse(expiredTime));
      Fluttertoast.showToast(
          msg: "Difference times ${timeDifferences.inMinutes}");
      condition(timeDifferences.inMinutes > 0);
    });

    // Close the subscription when this object is disposed
    addListener(() {
      if (!hasListeners) {
        subscription.cancel();
        _conditionController.close();
      }
    });
  }

  void startListening(String token) {
    // Replace this with the actual logic to continuously check the condition
    // You might check it based on events, network requests, or other sources.
    _conditionController.add(token);
  }
}
