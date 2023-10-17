import 'dart:isolate';

void coordinatorIsolate(SendPort coordinatorSendPort) async {
  final receivePort = ReceivePort();

  // Listen for messages from the worker isolates
  receivePort.listen((message) {
    print('Coordinator received: $message');
  });

  // Send messages to the worker isolates
  for (var i = 0; i < 2; i++) {
    final workerSendPort = await workerIsolate(i, receivePort.sendPort);
    workerSendPort.send('Coordinator: Hello Worker $i');
  }
}

Future<SendPort> workerIsolate(int id, SendPort coordinatorSendPort) async {
  final receivePort = ReceivePort();
  final sendPort = receivePort.sendPort;

  // Listen for messages from the coordinator
  receivePort.listen((message) {
    print('Worker $id received: $message');
    // Respond to the coordinator
    coordinatorSendPort.send('Worker $id: Received');
  });

  // Send the worker's sendPort to the coordinator
  coordinatorSendPort.send(sendPort);

  return sendPort;
}

void initializeMultiples() async {
  final coordinatorReceivePort = ReceivePort();
  final coordinatorSendPort = coordinatorReceivePort.sendPort;

  Isolate.spawn(coordinatorIsolate, coordinatorSendPort);

  // The coordinatorIsolate will handle communication from here
}
