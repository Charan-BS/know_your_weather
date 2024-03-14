import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.uri);
  final String uri;
  Future getData() async {
    http.Response response = await http.get(Uri.parse(uri));
    var data = response.body;
    if (response.statusCode == 200) {
      print('Resp:${response.body.toString()}');
      print('success');
      return jsonDecode(data);
    } else {
      const AlertDialog(
        title: Text('City not found'),
      );
      print('failure');
    }
  }
}
