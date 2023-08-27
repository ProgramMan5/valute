import 'package:flutter/material.dart';
import 'package:valute/data/user_currency_service.dart';

class ExchangeRatesModel extends ChangeNotifier {
  ExchangeRatesModel(this._userCurrencyService) {
    loadValue();
  }

  final UserCurrencyService _userCurrencyService; //экземпляр класса сервиса

  void loadValue() async {
    await _userCurrencyService.loadCurrencies();
    fillFirstValues();
    fillFSecondValues();
    currenciesDividing();
    notifyListeners();
  } // обращается к методу из модели который отправляет запрос

  void fillFirstValues() {
    _firstNameCurrency = _userCurrencyService.userData.firstCurrency.name;
    _firstCharCoreCurrency =
        _userCurrencyService.userData.firstCurrency.charCode;
    _firstRotes = _userCurrencyService.userData.firstCurrency.value;
  } //заполнение первого контейнера данными из модели

  void fillFSecondValues() {
    _secondNameCurrency = _userCurrencyService.userData.secondCurrency.name;
    _secondCharCoreCurrency =
        _userCurrencyService.userData.secondCurrency.charCode;
    _secondRotes = _userCurrencyService.userData.secondCurrency.value;
  } //заполнение второго контейнера данными из модели

  String _firstNameCurrency = ''; // имя валюты первого контейнера

  String get firstNameCurrency => _firstNameCurrency;

  String _firstCharCoreCurrency = ''; // айди валюты первого контейнера

  String get firstCharCodeCurrency => _firstCharCoreCurrency;

  String _secondNameCurrency = ''; // имя валюты второго контейнера

  String get secondNameCurrency => _secondNameCurrency;

  String _secondCharCoreCurrency = ''; // айди валюты второго контейнера

  String get secondCharCodeCurrency => _secondCharCoreCurrency;

  firstWidgetFilling() => _userCurrencyService.firstWidgetFilling =
      true; //заполняется первый контейнер

  secondWidgetFilling() => _userCurrencyService.firstWidgetFilling =
      false; //заполняется второй контейнер

  void fillCurrencyWidget() {
    if (_userCurrencyService.firstWidgetFilling) {
      fillFirstValues();
    } else {
      fillFSecondValues();
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

  bool _firstFieldActive = true; //активное поле ввода

  void makeFirstFieldActive() {
    _firstFieldActive = true;
  } // сделать поле ввода первого контейнера активным

  void makeSecondFieldActive() {
    _firstFieldActive = false;
  } // сделать поле ввода второго контейнера активным

  void currenciesDividing() {
    if (_firstFieldActive) {
      _secondFiledValue = calculateValue(
          _firstRotes, _secondRotes, double.parse(_firstFiledValue));
    } else {
      _firstFiledValue = calculateValue(
          _secondRotes, _firstRotes, double.parse(_secondFiledValue));
    }
    // notifyListeners();
  } //функция подсчета курса

  String calculateValue(double rateOne, double rateTwo, double value) {
    var result = ((rateOne / rateTwo) * value).toStringAsFixed(2).toString();
    if (result.substring(result.length - 3, result.length) == '.00') {
      result = result.substring(0, result.length - 3);
    }
    return result;
  }

  String _deterningActiveField() {
    if (_firstFieldActive) {
      return _firstFiledValue;
    } else {
      return _secondFiledValue;
    }
  }

  void _returnValueInField(String text) {
    if (_firstFieldActive) {
      _firstFiledValue = text;
    } else {
      _secondFiledValue = text;
    }
  }

  void numPress(String enterNumber) {
    String text = _deterningActiveField();
    if (enterNumber == '0' && text == '0') {
      return;
    } else if (text.length == 1 && text[0] == '0'&& text != '.') {
      text = '';
    }
    if (text.length < 10) {
      text += enterNumber;
    }
    _returnValueInField(text);
    currenciesDividing();
    notifyListeners();
  } //функция ввода цифр



  void delete() {
    String text = _deterningActiveField();
    text = text.substring(0, text.length - 1);
    if (text == '') {
      text = '0';
    }

    _returnValueInField(text);
    currenciesDividing();
    notifyListeners();
  } //функция удаления

  void totalDelete() {
    if (_firstFieldActive) {
      _firstFiledValue = '0';
    } else {
      _secondFiledValue = '0';
    }
    currenciesDividing();
    notifyListeners();
  } // функция тотального удаления
}
