import 'package:flutter/material.dart';
import 'package:valute/data/user_currency_data.dart';
import 'package:valute/domain/currency_data/currency_data.dart';


class ExchangeRatesModel extends ChangeNotifier {
  final UserCurrencyData _userCurrencyData;

  ExchangeRatesModel(this._userCurrencyData) {
    loadValue();
  }

  Future<List<CurrencyData>> loadValue() async {
    await _userCurrencyData.loadValue();
    notifyListeners();
    fillFirstValues();
    fillFSecondValues();
    return _userCurrencyData.getCurrencies;
  }

 void fillFirstValues(){
    _firstNameCurrency = _userCurrencyData.firstCurrencyName;
    _firstCharCoreCurrency = _userCurrencyData.firstCurrencyCharCode;
    _firstRotes = _userCurrencyData.firstCurrencyValue;
 }

  void fillFSecondValues(){
    _secondNameCurrency = _userCurrencyData.secondCurrencyName;
    _secondCharCoreCurrency = _userCurrencyData.secondCurrencyCharCode;
    _secondRotes = _userCurrencyData.secondCurrencyValue;
  }

 String _firstNameCurrency = '';

  String get firstNameCurrency => _firstNameCurrency;

  String _firstCharCoreCurrency = '';

  String get firstCharCodeCurrency => _firstCharCoreCurrency;

  String _secondNameCurrency = '';

  String get secondNameCurrency => _secondNameCurrency;

  String _secondCharCoreCurrency = '';

  String get secondCharCodeCurrency => _secondCharCoreCurrency;

  firstWidgetFilling() => _userCurrencyData.firstFillWidget = true;

  secondWidgetFilling() => _userCurrencyData.firstFillWidget = false;

  void fillCurrencyWidget() {
    if (_userCurrencyData.firstFillWidget) {
      _firstNameCurrency = _userCurrencyData.firstCurrencyName;
      _firstCharCoreCurrency = _userCurrencyData.firstCurrencyCharCode;
      _firstRotes = _userCurrencyData.firstCurrencyValue;
    } else {
      _secondNameCurrency = _userCurrencyData.secondCurrencyName;
      _secondCharCoreCurrency = _userCurrencyData.secondCurrencyCharCode;
      _secondRotes = _userCurrencyData.secondCurrencyValue;
    }
    notifyListeners();
  }

  String _firstFiledValue = '';

  String get firstFiledValue => _firstFiledValue;

  String _secondFiledValue = '';

  String get secondFiledValue => _secondFiledValue;

  double _firstRotes = 0;
  double _secondRotes = 0;

  bool _firstFieldActive = true;

  void makeFirstFieldActive() {
    _firstFieldActive = true;
    notifyListeners();
  }

  void makeSecondFieldActive() {
    _firstFieldActive = false;
    notifyListeners();
  }

  void currenciesDividing() {
    if (_firstFieldActive) {
      _secondFiledValue =
          ((_firstRotes / _secondRotes) * double.parse(_firstFiledValue))
              .toStringAsFixed(2)
              .toString();
      if (_secondFiledValue.substring(
              _secondFiledValue.length - 3, _secondFiledValue.length) ==
          '.00') {
        _secondFiledValue =
            _secondFiledValue.substring(0, _secondFiledValue.length - 3);
      }
    } else {
      _firstFiledValue =
          ((_secondRotes / _firstRotes) * double.parse(_secondFiledValue))
              .toStringAsFixed(2)
              .toString();
      if (_firstFiledValue.substring(
              _firstFiledValue.length - 3, _firstFiledValue.length) ==
          '.00') {
        _firstFiledValue =
            _firstFiledValue.substring(0, _firstFiledValue.length - 3);
      }
    }
    notifyListeners();
  }

  void numPress(String enterNumber) {
    if (_firstFieldActive) {
      _firstFiledValue += enterNumber;
    } else {
      _secondFiledValue += enterNumber;
    }
    currenciesDividing();
    notifyListeners();
  }

  void delete() {
    if (_firstFieldActive) {
      _firstFiledValue =
          _firstFiledValue.substring(0, _firstFiledValue.length - 1);
      if (_firstFiledValue == '') {
        _firstFiledValue = '0';
      }
    } else {
      _secondFiledValue =
          _secondFiledValue.substring(0, _secondFiledValue.length - 1);
      if (_secondFiledValue == '') {
        _secondFiledValue = '0';
      }
    }
    notifyListeners();
  }

  void totalDelete() {
    if (_firstFieldActive) {
      _firstFiledValue = '';
    } else {
      _secondFiledValue = '';
    }
    notifyListeners();
  }
}
