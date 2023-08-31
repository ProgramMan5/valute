import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    getDataTime();
    getChangeNowAndOldRate();
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
    getChangeNowAndOldRate();
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

  String _timeData = ''; //на какое время данные валюты актуальны
  String get timeData => _timeData;

  String percentChangeFirstValue = '';

  String percentChangeSecondValue = '';



  String calculateChangeValue(
    double rateOne,
    double rateTwo,
    double rateOneOld,
    double rateTwoOld,
  ) {
    var nowRate = (rateOne / rateTwo);
    var oldRate = (rateOneOld / rateTwoOld);
    var resuilt = (((nowRate - oldRate) / oldRate) * 100).toStringAsFixed(2);
    if (resuilt[0] != '-') {
      return resuilt = '+$resuilt';
    } else {
      return resuilt;
    }
  }//считает процентное соотношение курса сегодняшнего запроса и 3 дня назад от него

  void getChangeNowAndOldRate() {
    percentChangeFirstValue = calculateChangeValue(
        _userCurrencyService.userData.secondCurrency.value,
        _userCurrencyService.userData.firstCurrency.value,
        _userCurrencyService.userData.secondCurrency.previous,
        _userCurrencyService.userData.firstCurrency.previous);
    percentChangeSecondValue = calculateChangeValue(
        _userCurrencyService.userData.firstCurrency.value,
        _userCurrencyService.userData.secondCurrency.value,
        _userCurrencyService.userData.firstCurrency.previous,
        _userCurrencyService.userData.secondCurrency.previous);
  } //считает процентное соотношение курса сегодняшнего запроса и 3 дня назад от него

  void getDataTime() {
    String input = _userCurrencyService.userData.requestData.timestamp;
    input = input.substring(0, input.length - 6);
    String outputFormat = 'yyyy.MM.dd HH:mm';

    DateTime dateTime = DateTime.parse(input);
    _timeData = DateFormat(outputFormat).format(dateTime);
  } //парсит время с апи запроса в привычный формат

  void makeFirstFieldActive() {
    _firstFieldActive = true;
  } // сделать поле ввода первого контейнера активным

  void makeSecondFieldActive() {
    _firstFieldActive = false;
  } // сделать поле ввода второго контейнера активным

  void currenciesDividing() {
    if (_firstFieldActive) {
      var nominalSecondCurrency =
          _userCurrencyService.userData.secondCurrency.nominal;
      _secondFiledValue = calculateValue(_firstRotes, _secondRotes,
          double.parse(_firstFiledValue), nominalSecondCurrency);
    } else {
      var nominalFirstCurrency =
          _userCurrencyService.userData.firstCurrency.nominal;
      _firstFiledValue = calculateValue(_secondRotes, _firstRotes,
          double.parse(_secondFiledValue), nominalFirstCurrency);
    }
    // notifyListeners();
  } //функция подсчета курса

  String calculateValue(
      double rateOne, double rateTwo, double value, int nominal) {
    var result =
        (((rateOne / rateTwo) * value) * nominal).toStringAsFixed(2).toString();

    if (result.substring(result.length - 3, result.length) == '.00') {
      result = result.substring(0, result.length - 3);
    }
    return result;
  } //высчитывает курс

  String _deterningActiveField() {
    if (_firstFieldActive) {
      return _firstFiledValue;
    } else {
      return _secondFiledValue;
    }
  } //возвращает активное поле ввода

  void _returnValueInField(String text) {
    if (_firstFieldActive) {
      _firstFiledValue = text;
    } else {
      _secondFiledValue = text;
    }
  }//возвращает активное поле ввода

  void numPress(String enterNumber) {
    String text = _deterningActiveField();
    if ((enterNumber == '0' || enterNumber == '00') && text == '0') {
      return;
    } else if (text.length == 1 && text[0] == '0') {
      text = '';
    }
    if (text.length < 9) {
      text += enterNumber;
    }
    _returnValueInField(text);
    currenciesDividing();
    notifyListeners();
  } // ввод цифр

  void commaPressed() {
    String text = _deterningActiveField();
    if (!text.contains('.')) {
      text += '.';
    }
    _returnValueInField(text);
    currenciesDividing();
    notifyListeners();
  } //ввод точки

  void delete() {
    String text = _deterningActiveField();
    text = text.substring(0, text.length - 1);
    if (text == '') {
      text = '0';
    }
    _returnValueInField(text);
    currenciesDividing();
    notifyListeners();
  } // удаление

  void totalDelete() {
    if (_firstFieldActive) {
      _firstFiledValue = '0';
    } else {
      _secondFiledValue = '0';
    }
    currenciesDividing();
    notifyListeners();
  } //  тотальное удаление
}
