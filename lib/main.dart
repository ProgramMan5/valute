import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valute/data/user_currency_service.dart';
import 'package:valute/ui/screens/currency_list/currency_list.dart';
import 'package:valute/ui/screens/currency_list/currency_list_model.dart';
import 'package:valute/ui/screens/exchange_rates/exchange_rates.dart';
import 'package:valute/ui/screens/exchange_rates/exchange_rates_model.dart';
import 'package:valute/ui/theme/colors.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final UserCurrencyService _userCurrencyService = UserCurrencyService();
   MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ExchangeRatesModel(_userCurrencyService),
        ),
        ChangeNotifierProvider(
          create: (context) => ColorsTheme(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrencyListModel(_userCurrencyService),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/exchange_rates': (context) => const ExchangeRates(),
          '/currency_list': (context) => const CurrencyList(),
        },
        initialRoute: '/exchange_rates',
      ),
    );
  }
}
