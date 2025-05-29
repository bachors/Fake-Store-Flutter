import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/store_model.dart';

List<Store> parseStore(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var stores = list.map((e) => Store.fromJson(e)).toList();
  return stores;
}

Future<List<Store>> fetchStores() async {
  final http.Response response = await http.get(Uri.parse('https://api.npoint.io/62aeea8b12f5d65a066c'));
  if (response.statusCode == 200) {
    return compute(parseStore, response.body);
  } else {
    throw Exception(response.statusCode);
  }
}