import 'package:valute/data/user_data.dart';
import 'package:valute/domain/api_client/api_client.dart';
import 'package:valute/domain/currency_data/currency_data.dart';
import 'package:valute/domain/request_data/request_data.dart';

class UserCurrencyService {
  final _apiClient = ApiClient();
  final _currencies = <CurrencyData>[];

  List<CurrencyData> get currenciesData => List.unmodifiable(_currencies);
  bool firstWidgetFilling = true;

  UserData get userData => _userData;


  UserData _userData = UserData(
    RequestData(
      date: '',
      previousDate: '',
      previousURL: '',
      timestamp: '',
      valute: {},
    ),
    CurrencyData(
      id: '',
      numCode: '',
      charCode: '',
      nominal: 0,
      name: '',
      value: 0,
      previous: 0,
    ),
    CurrencyData(
      id: '',
      numCode: '',
      charCode: '',
      nominal: 0,
      name: '',
      value: 0,
      previous: 0,
    ),
  );
  String firstCurrencyName = 'Доллар США';
  String secondCurrencyName = 'Евро';

  void changeCurrency(String name) {
    if (firstWidgetFilling) {
      firstCurrencyName = name;
      fillFirstCurrencyValues();
    } else {
      secondCurrencyName = name;
      fillSecondCurrencyValues();
    }
  }

  Future<void> loadCurrencies() async {
    final currenciesResponse = await _apiClient.getCarrencyData();
    _currencies.addAll(currenciesResponse.valute.values.toList());
    _userData = _userData.copyWith(requestData: currenciesResponse);
    List.from(_currencies);
    fillFirstCurrencyValues();
    fillSecondCurrencyValues();
  } // загружает данные

  void fillFirstCurrencyValues() {
    for (CurrencyData currency in _currencies) {
      if (currency.name.contains(firstCurrencyName)) {
        _userData = _userData.copyWith(firstCurrency: currency);
      }
    }
  } //заполняет данные второй валюты по ее имени

  void fillSecondCurrencyValues() {
    for (CurrencyData currency in _currencies) {
      if (currency.name.contains(secondCurrencyName)) {
        _userData = _userData.copyWith(secondCurrency: currency);
      }
    }
  } //заполняет данные первой валюты по ее имени
}
