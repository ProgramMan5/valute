import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valute/domain/api_client/api_client.dart';
import 'package:valute/ui/screens/currency_list/currency_list.dart';
import 'package:valute/ui/screens/currency_list/currency_list_model.dart';
import 'package:valute/ui/screens/exchange_rates/exchange_rates.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
final currencyListModel = CurrencyListModel();


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiClient()),
        ChangeNotifierProvider.value(value: currencyListModel),
      ],
      child: ResponsiveApp(
        builder: (context) => MaterialApp(
          routes: {
            '/exchange_rates': (context) => const ExchangeRates(),
            '/currency_list': (context) => const CurrencyList(),
          },
          initialRoute: '/currency_list',
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    currencyListModel.loadCurrencies();
  }
}

