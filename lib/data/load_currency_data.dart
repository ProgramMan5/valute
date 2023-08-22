import 'package:flutter/cupertino.dart';
import 'package:valute/domain/api_client/api_client.dart';
import 'package:valute/domain/currency_data/currency_data.dart';

class LoadCurrencyData extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _currencies = <CurrencyData>[];

  List<CurrencyData> get currenciesData => List.unmodifiable(_currencies);

  Future<void> loadCurrencies() async {
    final currenciesResponse = await _apiClient.getCarrencyData();
    _currencies.addAll(currenciesResponse.valute.values.toList());
    List.from(_currencies);
  }
}
