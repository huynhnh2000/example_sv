import 'dart:async';
import 'dart:io';

import 'package:socks5_proxy/socks_server.dart';

Future<void> main() async {
  // Create server instance
  final proxy = SocksServer();
  // Listen to all tcp and udp connections
  proxy.connections.listen((connection) async {
    // Apply default handler
    await connection.forward();
  }).onError(print);

  var interfaces = await NetworkInterface.list();
  for (var interface in interfaces) {
    for (var addr in interface.addresses) {
      if (addr.type == InternetAddressType.IPv4) {
        final server = await ServerSocket.bind(addr, 0);
        print('SOCKS5 Proxy listening on ${server.address}:${server.port}');
      }
    }
  }

  // Bind servers
  // await proxy.bind(server.address, server.port);
}



// import 'package:example_sv/api.dart';
// import 'package:flutter/material.dart';
// import 'package:shelf/shelf.dart' as shelf;
// import 'package:shelf/shelf_io.dart' as shelf_io;

// void main() {
//   final app = Api().router;
//   var handler = const shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(app);

//   shelf_io.serve(handler, '127.0.0.1', 8080).then((server) {
//     print('Proxy server listening on address ${server.address} on port ${server.port}');
//   });
// }

// import 'dart:async';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// Future<void> main() async {
//   // Địa chỉ của ứng dụng đích
//   final targetUrl = 'http://127.0.0.1';

//   // Tạo một server proxy để lắng nghe yêu cầu
//   final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);

//   print('Listening on ${server.address}:${server.port}');

//   await for (HttpRequest request in server) {
//     // Chuyển tiếp yêu cầu đến ứng dụng đích và nhận phản hồi
//     final targetResponse = await http.get(Uri.parse(targetUrl + request.uri.toString()));

//     // Sao chép header và body từ phản hồi ứng dụng đích đến yêu cầu proxy
//     request.response
//       ..headers
//       ..add(targetResponse.bodyBytes);

//     await request.response.close();
//   }
// }
