import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void coordinatorIsolate(List<Object> args) async {
  final rootIsolateToken = args[0] as RootIsolateToken;
  final sendPort = args[1] as SendPort;
  final receivePort = ReceivePort();
  print("token is $rootIsolateToken");
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  // Listen for messages from the worker isolates
  receivePort.listen((message) {
    print('Coordinator received: $message');
  });

  // Send messages to the worker isolates
  for (var i = 0; i < 2; i++) {
    final workerSendPort = await workerIsolate(i, receivePort.sendPort);
    workerSendPort.send(i == 0 ? 10 : 20);
  }
}

Future<SendPort> workerIsolate(int id, SendPort coordinatorSendPort) async {
  final receivePort = ReceivePort();
  final sendPort = receivePort.sendPort;

  // Listen for messages from the coordinator
  receivePort.listen((message) {
    print('Worker $id received: $message');

    int factorial = factorialData(message);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      Fluttertoast.showToast(
          msg: "Check something from internet ${timer.tick}");
      if (timer.tick.isEven) {
        coordinatorSendPort.send('Worker $id: timer value of ${timer.tick}');
      }
      if (timer.tick > 10) {
        timer.cancel();
      }
    });

    // Respond to the coordinator
    coordinatorSendPort
        .send('Worker $id: Received and get factorial is $factorial');
  });

  // Send the worker's sendPort to the coordinator
  coordinatorSendPort.send(sendPort);

  return sendPort;
}

void initializeMultiples() async {
  final coordinatorReceivePort = ReceivePort();
  final coordinatorSendPort = coordinatorReceivePort.sendPort;
  RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
  print("token $rootIsolateToken");
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken!);
  Isolate.spawn(coordinatorIsolate, [rootIsolateToken, coordinatorSendPort]);

  // The coordinatorIsolate will handle communication from here
}

int factorialData(int n) {
  if (n == 0) {
    return 1;
  }
  return n * factorialData(n - 1);
}

int getTimerValue() {
  Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    Fluttertoast.showToast(msg: "Check something from internet ${timer.tick}");
    if (timer.tick > 20) {
      timer.cancel();
    }
  });
  return timer.tick;
}
