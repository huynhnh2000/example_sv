import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Api {
  Router get router {
    final router = Router();

    router.get('/api/greet', (Request request) {
      final responseMap = {'message': 'Hello, World!'};
      final responseJson = jsonEncode(responseMap);

      return Response.ok(responseJson, headers: {'content-type': 'application/json'});
    });

    return router;
  }
}
