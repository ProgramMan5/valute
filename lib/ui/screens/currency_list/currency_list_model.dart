import 'package:flutter/material.dart';
import 'package:valute/data/user_currency_service.dart';
import 'package:valute/domain/currency_data/currency_data.dart';

class CurrencyListModel extends ChangeNotifier {
  CurrencyListModel(this._userCurrencyService) {
    getValue();
    searchCurrency();
  }

  final UserCurrencyService _userCurrencyService;

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
    _currencies = _userCurrencyService.currenciesData;
    notifyListeners();
  } //заполняет переменные полученными с запроса данными

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

  void outForBackButton() {
    _searchController.text = '';
    searchCurrency();
    notifyListeners();
  }

  void fillCurrencyWidget(int index) async {
    final currency = filteredCurrencies[index];
    _userCurrencyService.changeCurrency(currency.name);
    _searchController.text = '';
    searchCurrency();
  }
} // функция изменения данных модели
