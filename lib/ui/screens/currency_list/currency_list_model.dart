import 'package:flutter/material.dart';
import 'package:valute/data/user_currency_data.dart';
import 'package:valute/domain/currency_data/currency_data.dart';
import 'package:valute/ui/screens/exchange_rates/exchange_rates_model.dart';

class CurrencyListModel extends ChangeNotifier {
  CurrencyListModel(this._userCurrencyData, this._exchangeRatesModel){getValue();}

  final ExchangeRatesModel _exchangeRatesModel;
  final UserCurrencyData _userCurrencyData;

  List<CurrencyData> _currencies = [];

  List<CurrencyData> get currencies => _currencies;

  List<CurrencyData> _filteredCurrencies = [];

  List<CurrencyData> get filteredCurrencies => _filteredCurrencies;

  void getValue() async {
    _filteredCurrencies = _userCurrencyData.getCurrencies;
    _currencies = _userCurrencyData.getCurrencies;
    notifyListeners();
  }

  void callExchangeRatesFunction() {
    _exchangeRatesModel.fillCurrencyWidget();
  }

  final _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  void searchCurrency() {
    final String searchText = searchController.text.toLowerCase();
    if (searchText.isEmpty) {
      _filteredCurrencies = _currencies;
    } else {
      _filteredCurrencies = _currencies
          .where((currency) => currency.name.toLowerCase().contains(searchText))
          .toList();
    }
    notifyListeners();
  }

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
}

// class CurrencyListModel extends ChangeNotifier {
//   CurrencyListModel(this._userCurrencyData, this._exchangeRatesModel) {
//     loadValue();
//   }
//
//   final ExchangeRatesModel _exchangeRatesModel;
//   final UserCurrencyData _userCurrencyData;
//
//   final _loadCurrency = LoadCurrencyData();
//
//   List<CurrencyData> get _currencies => _loadCurrency.currenciesData;
//
//   List<CurrencyData> get currencies => List.unmodifiable(_currencies);
//
//   List<CurrencyData> _filteredCurrencies = [];
//
//   List<CurrencyData> get filteredCurrencies =>
//       List.unmodifiable(_filteredCurrencies);
//
//   void loadValue() async {
//     await _loadCurrency.loadCurrencies();
//     _filteredCurrencies = _currencies;
//     notifyListeners();
//   }
//
//   void callExchangeRatesFunction() {
//     _exchangeRatesModel.fillCurrencyWidget();
//   }
//
//   final _searchController = TextEditingController();
//
//   TextEditingController get searchController => _searchController;
//
//   void searchCurrency() {
//     final String searchText = searchController.text.toLowerCase();
//     if (searchText.isEmpty) {
//       _filteredCurrencies = _currencies;
//     } else {
//       _filteredCurrencies = _currencies
//           .where((currency) => currency.name.toLowerCase().contains(searchText))
//           .toList();
//     }
//     notifyListeners();
//   }
//
//   void fillCurrencyWidget(int index) async {
//     final currency = filteredCurrencies[index];
//     if (_userCurrencyData.firstFillWidget) {
//       _userCurrencyData.firstCurrencyName = currency.name;
//       _userCurrencyData.firstCurrencyCharCode = currency.charCode;
//       _userCurrencyData.firstCurrencyValue = currency.value;
//     } else {
//       _userCurrencyData.secondCurrencyName = currency.name;
//       _userCurrencyData.secondCurrencyCharCode = currency.charCode;
//       _userCurrencyData.secondCurrencyValue = currency.value;
//     }
//     callExchangeRatesFunction();
//     _searchController.text = '';
//     searchCurrency();
//     notifyListeners();
//   }
// }
