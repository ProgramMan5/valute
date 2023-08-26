import 'package:valute/domain/currency_data/currency_data.dart';
import 'package:valute/domain/request_data/request_data.dart';

class UserData {
  final RequestData requestData;
  final CurrencyData firstCurrency;
  final CurrencyData secondCurrency;

  const UserData(
    this.requestData,
    this.firstCurrency,
    this.secondCurrency,
  );

  UserData copyWith({
    RequestData? requestData,
    CurrencyData? firstCurrency,
    CurrencyData? secondCurrency,
  }) {
    return UserData(
      requestData ?? this.requestData,
      firstCurrency ?? this.firstCurrency,
      secondCurrency ?? this.secondCurrency,
    );
  }
}