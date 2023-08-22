import 'package:flutter/cupertino.dart';
import 'package:valute/domain/currency_data/currency_data.dart';
import 'package:valute/ui/screens/exchange_rates/exchange_rates_model.dart';
import 'load_currency_data.dart';

class UserCurrencyData extends ChangeNotifier {
  String firstCurrencyName = '';
  String firstCurrencyCharCode = '';
  double firstCurrencyValue = 0;
  String secondCurrencyName = '';
  String secondCurrencyCharCode = '';
  double secondCurrencyValue = 0;
  bool firstFillWidget = false;

  final _loadCurrency = LoadCurrencyData();

  List<CurrencyData> get _currencies => _loadCurrency.currenciesData;

  List<CurrencyData> getCurrencies = [];

  Future<void> loadValue() async {
    await _loadCurrency.loadCurrencies();
    getCurrencies = _currencies;
    fillFirstValues();
    fillSecondValues();
    notifyListeners();
  }

  void fillFirstValues() {
    for (CurrencyData currency in getCurrencies) {
      if (currency.name.contains('Доллар США')) {
        firstCurrencyName = currency.name;
        firstCurrencyCharCode = currency.charCode;
        firstCurrencyValue = currency.value;
      }
    }
  }
  void fillSecondValues() {
    for (CurrencyData currency in getCurrencies) {
      if (currency.name.contains('Евро')) {
        secondCurrencyName = currency.name;
        secondCurrencyCharCode = currency.charCode;
        secondCurrencyValue = currency.value;
      }
    }
  }
}
