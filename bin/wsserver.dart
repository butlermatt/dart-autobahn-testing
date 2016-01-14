import 'dart:io';

import 'package:logging/logging.dart';

main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.loggerName}-${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  var logger = new Logger('WS-Server');

  // var comp = new CompressionOptions(
  //                               clientNoContextTakeover: true,
  //                               serverNoContextTakeover: true,
  //                               clientMaxWindowBits: 15,
  //                               serverMaxWindowBits: 15,
  //                               enabled: true);

  var server = await HttpServer.bind('0.0.0.0', 9001);
  await for (HttpRequest req in server) {
    logger.info('Received request');
    if (!WebSocketTransformer.isUpgradeRequest(req)) {
      logger.info('Request is not upgrade request');
      req.response.close();
      continue;
    }

    var wsServer = await WebSocketTransformer.upgrade(req/*, compression: comp*/);
    //logger.info('Upgraded socket');
    await for (var message in wsServer) {
      //  logger.finest('Received message: $message');
      //  logger.finest('Message Length: ${message.length}');
      wsServer.add(message);
    }
  }
}
