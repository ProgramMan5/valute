import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valute/ui/screens/exchange_rates/exchange_rates.dart';
import 'package:valute/ui/screens/exchange_rates/exchange_rates_model.dart';
import 'package:valute/ui/theme/colors.dart';
import 'currency_list_model.dart';

class CurrencyList extends StatelessWidget {
  const CurrencyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Provider.of<ColorsTheme>(context);
    final model = Provider.of<CurrencyListModel>(context);
    final exchangeRatesModel = Provider.of<ExchangeRatesModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: color.colorOfAppBar,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                model.outForBackButton();
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExchangeRates(),
                  ),
                );
              },
              icon: Icon(
                color: color.colorOfIconsAppBar,
                Icons.navigate_before,
              ),
              iconSize: 30,
            ),
            const Text(
              'Выберите валюту',
              style: TextStyle(fontSize: 20),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                color: color.colorOfIconsAppBar,
                Icons.refresh,
              ),
              iconSize: 30,
            ),
          ],
        ),
      ),
      backgroundColor: color.colorOfBackground,
      body: model.currencies.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.only(top: 80),
                  itemCount: model.filteredCurrencies.length,
                  itemBuilder: (BuildContext context, int index) {
                    final currency = model.filteredCurrencies[index];
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            model.fillCurrencyWidget(index);
                            exchangeRatesModel.fillCurrencyWidget();
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ExchangeRates(),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: const Alignment(-0.2, 3),
                                end: const Alignment(2.6, 0),
                                colors: <Color>[
                                  color.colorOfRatesWidget,
                                  color.lightBlue,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      currency.charCode,
                                      style: const TextStyle(fontSize: 46),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      currency.name,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: model.searchController,
                    onChanged: (value) {
                      model.searchCurrency();
                    },
                    decoration: InputDecoration(
                      labelText: 'Поиск',
                      filled: true,
                      fillColor: color.colorOfText.withAlpha(225),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
