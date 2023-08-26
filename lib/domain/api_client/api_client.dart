import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:valute/domain/request_data/request_data.dart';

class ApiClient extends ChangeNotifier {
  final _client = HttpClient();
  Future<RequestData> getCarrencyData() async {
    final url = Uri.parse('https://www.cbr-xml-daily.ru/daily_json.js');
    final request = await _client.getUrl(url);
    final response = await request.close();

    final json = await response
        .transform(utf8.decoder)
        .join()
        .then((value) => jsonDecode(value) as Map<String, dynamic>);

    final currency = RequestData.fromJson(json);
    print('ApiClient');
    return currency;
  }
}