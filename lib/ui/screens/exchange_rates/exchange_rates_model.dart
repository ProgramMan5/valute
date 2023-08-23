import 'package:flutter/material.dart';
import 'package:valute/data/user_currency_data.dart';
import 'package:valute/domain/currency_data/currency_data.dart';

class ExchangeRatesModel extends ChangeNotifier {
  ExchangeRatesModel(this._userCurrencyData) {
    loadValue(); //вызывает апи запрос
    print('apiCallGetInRatesNodel');
  }

  final UserCurrencyData _userCurrencyData; //экземпляр модели

  Future<List<CurrencyData>> loadValue() async {
    await _userCurrencyData.loadValue();
    notifyListeners();
    fillFirstValues();
    fillFSecondValues();
    currenciesDividing();
    return _userCurrencyData.getCurrencies;
  } // обращается к методу из модели который отправляет запрос

  void fillFirstValues() {
    _firstNameCurrency = _userCurrencyData.firstCurrencyName;
    _firstCharCoreCurrency = _userCurrencyData.firstCurrencyCharCode;
    _firstRotes = _userCurrencyData.firstCurrencyValue;
  } //заполнение первого контейнера данными из модели

  void fillFSecondValues() {
    _secondNameCurrency = _userCurrencyData.secondCurrencyName;
    _secondCharCoreCurrency = _userCurrencyData.secondCurrencyCharCode;
    _secondRotes = _userCurrencyData.secondCurrencyValue;
  } //заполнение второго контейнера данными из модели

  String _firstNameCurrency = ''; // имя валюты первого контейнера

  String get firstNameCurrency => _firstNameCurrency;

  String _firstCharCoreCurrency = ''; // айди валюты первого контейнера

  String get firstCharCodeCurrency => _firstCharCoreCurrency;

  String _secondNameCurrency = ''; // имя валюты второго контейнера

  String get secondNameCurrency => _secondNameCurrency;

  String _secondCharCoreCurrency = ''; // айди валюты второго контейнера

  String get secondCharCodeCurrency => _secondCharCoreCurrency;

  firstWidgetFilling() =>
      _userCurrencyData.firstFillWidget = true; //заполняется первый контейнер

  secondWidgetFilling() =>
      _userCurrencyData.firstFillWidget = false; //заполняется второй контейнер

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
    currenciesDividing();
    notifyListeners();
  } // взять данные из модели и заполнить ими активный контейнер

  String _firstFiledValue = '1'; //цифры количества первой валюты

  String get firstFiledValue => _firstFiledValue;

  String _secondFiledValue = ''; //цифры количества второй валюты

  String get secondFiledValue => _secondFiledValue;

  double _firstRotes = 0; // курс (к рублю) первой валюты
  double _secondRotes = 0; // курс (к рублю) второй валюты

  bool _firstFieldActive = true;

  void makeFirstFieldActive() {
    _firstFieldActive = true;
    notifyListeners();
  } // сделать поле ввода первого контейнера активным

  void makeSecondFieldActive() {
    _firstFieldActive = false;
    notifyListeners();
  } // сделать поле ввода второго контейнера активным

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
  } // функция подсчета курса

  void numPress(String enterNumber) {
    if (_firstFieldActive) {
      if (enterNumber == '0' && _firstFiledValue == '0') {
        return;
      } else if (_firstFiledValue.length == 1 && _firstFiledValue[0] == '0') {
        _firstFiledValue = '';
      }
      if (_firstFiledValue.length < 10) {
        _firstFiledValue += enterNumber;
      }
    } else {
      if (enterNumber == '0' && _secondFiledValue == '0') {
        return;
      } else if (_secondFiledValue.length == 1 && _secondFiledValue[0] == '0') {
        _secondFiledValue = '';
      }
      if (_secondFiledValue.length < 12) {
        _secondFiledValue += enterNumber;
      }
    }
    currenciesDividing();
    notifyListeners();
  } // функция ввода текста

  ///убрать повторение

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
    currenciesDividing();
    notifyListeners();
  } //функция деления

  ///убрать повторение

  void totalDelete() {
    if (_firstFieldActive) {
      _firstFiledValue = '0';
    } else {
      _secondFiledValue = '0';
    }
    currenciesDividing();
    notifyListeners();
  }

} // функция тотального деления
