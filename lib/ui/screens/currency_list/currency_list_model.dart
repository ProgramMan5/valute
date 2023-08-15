import 'package:flutter/material.dart';
import 'package:valute/domain/api_client/api_client.dart';
import 'package:valute/domain/currency_data/currency_data.dart';


class CurrencyListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _currencies = <CurrencyData>[];

  List<CurrencyData> get currencies => List.unmodifiable(_currencies);

  Future<void> loadCurrencies() async {
    final currenciesResponse = await _apiClient.getCarrencyData();
    _currencies.addAll(currenciesResponse.valute.values.toList());
    // делаем из коллекции currenciesResponse список _currencies
    notifyListeners();

  }
}
