import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valute/data/load_currency_data.dart';
import 'package:valute/data/user_currency_data.dart';
import 'package:valute/domain/api_client/api_client.dart';
import 'package:valute/ui/screens/currency_list/currency_list.dart';
import 'package:valute/ui/screens/currency_list/currency_list_model.dart';
import 'package:valute/ui/screens/exchange_rates/exchange_rates.dart';
import 'package:valute/ui/screens/exchange_rates/exchange_rates_model.dart';
import 'package:valute/ui/theme/colors.dart';

void main() {
  runApp(  MyApp());
}
///как то добавить конст
class MyApp extends StatelessWidget {
  final UserCurrencyData userCurrencyData = UserCurrencyData();

   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoadCurrencyData(),
        ),
        ChangeNotifierProvider(
          create: (context) => ApiClient(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExchangeRatesModel(UserCurrencyData()),
        ),
        ChangeNotifierProvider(
          create: (context) => ColorsTheme(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrencyListModel(
            UserCurrencyData(),
            Provider.of<ExchangeRatesModel>(context, listen: false),
          ),
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
