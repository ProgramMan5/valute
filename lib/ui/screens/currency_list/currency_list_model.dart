import 'package:flutter/material.dart';
import 'package:valute/data/user_currency_data.dart';
import 'package:valute/domain/currency_data/currency_data.dart';
import 'package:valute/ui/screens/exchange_rates/exchange_rates_model.dart';

class CurrencyListModel extends ChangeNotifier {
  CurrencyListModel(this._userCurrencyData, this._exchangeRatesModel) {
    getValue(); //заполняет лист
  }

  final ExchangeRatesModel
      _exchangeRatesModel; // экземпляр класса второй вью модели
  final UserCurrencyData _userCurrencyData; //экземпляр класса хранения данных

  final _searchController =
      TextEditingController(); // текстовый контроллер поиска

  TextEditingController get searchController => _searchController;

  List<CurrencyData> _currencies =
      []; // список валют основной (не изменяется после получения данных)

  List<CurrencyData> get currencies => _currencies;

  List<CurrencyData> _filteredCurrencies =
      []; //список валют для поиска (меняется)

  List<CurrencyData> get filteredCurrencies => _filteredCurrencies;

  void getValue() async {
    _filteredCurrencies = _userCurrencyData.getCurrencies;

    _currencies = _userCurrencyData.getCurrencies;
    notifyListeners();
  } //заполняет переменные полученными с запроса данными

  void callExchangeRatesFunction() {
    _exchangeRatesModel.fillCurrencyWidget();
  } //вызывает функцию вызова у второй вью модели метода заполнения данных с модели

  void searchCurrency() {
    final String searchText = _searchController.text.toLowerCase();
    if (searchText.isEmpty) {
      _filteredCurrencies = _currencies;
    } else {
      _filteredCurrencies = _currencies
          .where((currency) => currency.name.toLowerCase().contains(searchText))
          .toList();
    }
    notifyListeners();
  } //функция поиска

  void fillCurrencyWidget(int index) async {
    final currency = filteredCurrencies[index];
    if (_userCurrencyData.firstFillWidget) {
      _userCurrencyData.firstCurrencyName = currency.name;
      _userCurrencyData.firstCurrencyCharCode = currency.charCode;
      _userCurrencyData.firstCurrencyValue = currency.value;
    } else {
      _userCurrencyData.secondCurrencyName = currency.name;
      _userCurrencyData.secondCurrencyCharCode = currency.charCode;
      _userCurrencyData.secondCurrencyValue = currency.value;
    }
    callExchangeRatesFunction();
    _searchController.text = '';
    searchCurrency();
    notifyListeners();
  }
} // функция изменения данных модели
