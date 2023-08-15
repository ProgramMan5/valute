import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'currency_list_model.dart';


class CurrencyList extends StatelessWidget {
  const CurrencyList({super.key});

  @override
  Widget build(BuildContext context) {

    final model = Provider.of<CurrencyListModel>(context);
    return Scaffold(
      body: model.currencies.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: model.currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final currency = model.currencies[index];
                return Center(
                  child: Column(
                    children: [
                      Text(currency.name),
                      Text(currency.value.toString())
                    ],
                  ),
                );
              },
            ),
    );
  }
}

