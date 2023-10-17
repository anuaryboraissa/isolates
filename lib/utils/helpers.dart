import 'dart:isolate';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

String getJwtExpiredTime(String token) {
  if (JwtDecoder.isExpired(token)) {
    // Token has already expired
    Fluttertoast.showToast(msg: "JWT token already expired");
    return "";
  } else {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    // Get the expiration time in milliseconds since epoch
    int expirationTimeMillis = decodedToken['exp'] * 1000;

    // Convert milliseconds since epoch to a DateTime object
    DateTime expirationDateTime =
        DateTime.fromMillisecondsSinceEpoch(expirationTimeMillis);
    // print('Token expires at: $expirationDateTime');
    return expirationDateTime.toString();
  }
}

void initialize() async {
  final receivePort = ReceivePort();

  // Spawn a new isolate
  await Isolate.spawn(isolateFunction, receivePort.sendPort);

  // Listen for messages from the spawned isolate
  receivePort.listen((data) {
    print('Received from isolate: $data');
  }); // Terminate the isolate
}

void isolateFunction(SendPort sendPort) {
  sendPort.send('Message from the isolate');
}
