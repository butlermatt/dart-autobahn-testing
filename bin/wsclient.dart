import 'dart:io';

import 'package:logging/logging.dart';

main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.loggerName}-${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  var logger = new Logger('WS-Client');

  int numTests;

  var ws = await WebSocket.connect('ws://localhost:9001/getCaseCount?agent=Dart');
  await for (String msg in ws) {
    numTests = int.parse(msg.trim());
  }

  logger.fine('Found: $numTests tests');
  for (var i = 1; i <= numTests; i++) {
    logger.fine('Running test: $i');
    ws = await WebSocket.connect(
        'ws://localhost:9001/runCase?case=$i&agent=Dart');

    await for (var msg in ws) {
      ws.add(msg);
//      logger.fine('Message Length: ${msg.length}');
//      logger.fine('Message: $msg');
    }
  }

  ws =
      await WebSocket.connect('ws://localhost:9001/updateReports?agent=Dart');
}
