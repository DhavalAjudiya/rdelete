import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:rapidellete/modal/post_data_modal.dart';

enum ApiType {
  aPost,
  adelete,
}

class API {
  static http.Response? response;

  static Future apiHandler(
      {@required String? url,
      @required ApiType? apiType,
      Map<String, dynamic>? body,
      Map<String, String>? header}) async {
    try {
      if (apiType == ApiType.aPost) {
        var reqBody = jsonEncode(body);
        response =
            await http.post(Uri.parse(url!), body: body, headers: header);
      } else {
        response =
            await http.delete(Uri.parse(url!), body: body, headers: header);
      }

      if (response!.statusCode == 200) {
        return response!.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
