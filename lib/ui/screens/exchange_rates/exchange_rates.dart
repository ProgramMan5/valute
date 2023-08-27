import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valute/ui/screens/currency_list/currency_list.dart';
import 'package:valute/ui/theme/colors.dart';
import 'exchange_rates_model.dart';

class ExchangeRates extends StatelessWidget {
  const ExchangeRates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Provider.of<ColorsTheme>(context);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: color.colorOfAppBar,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  color: color.colorOfIconsAppBar,
                  Icons.navigate_before,
                ),
                iconSize: 30,
              ),
              const Text(
                'Конветер валют',
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
          )),
      backgroundColor: const Color.fromRGBO(54, 62, 83, 1),
      body: const ExchangeRatesBody(),
    );
  }
}

class ExchangeRatesBody extends StatelessWidget {
  const ExchangeRatesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Provider.of<ColorsTheme>(context);
    final model = Provider.of<ExchangeRatesModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            _RotesContainer(
                choiceInputField: model.makeFirstFieldActive,
                colorOfRatesWidget: color.colorOfRatesWidget,
                colorOfIconWidget: color.colorOfIconsWidget,
                charCodeCurrency: model.firstCharCodeCurrency,
                valueField: model.firstFiledValue,
                nameCurrency: model.firstNameCurrency,
                widgetFilling: () {
                  model.firstWidgetFilling();
                }),
            const SizedBox(
              height: 24,
            ),
            Image(
              image: color.vectorVertical,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 24,
            ),
            _RotesContainer(
                choiceInputField: model.makeSecondFieldActive,
                colorOfRatesWidget: color.colorOfRatesWidget,
                colorOfIconWidget: color.colorOfIconsWidget,
                charCodeCurrency: model.secondCharCodeCurrency,
                valueField: model.secondFiledValue,
                nameCurrency: model.secondNameCurrency,
                widgetFilling: () {
                  model.secondWidgetFilling();
                }),
            const SizedBox(
              height: 80,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _Button(
                          onPressed: () {
                            model.numPress('1');
                          },
                          text: '1',
                        ),
                        _Button(
                          onPressed: () {
                            model.numPress('2');
                          },
                          text: '2',
                        ),
                        _Button(
                          onPressed: () {
                            model.numPress('3');
                          },
                          text: '3',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _Button(
                          onPressed: () {
                            model.numPress('4');
                          },
                          text: '4',
                        ),
                        _Button(
                          onPressed: () {
                            model.numPress('5');
                          },
                          text: '5',
                        ),
                        _Button(
                          onPressed: () {
                            model.numPress('6');
                          },
                          text: '6',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _Button(
                          onPressed: () {
                            model.numPress('7');
                          },
                          text: '7',
                        ),
                        _Button(
                          onPressed: () {
                            model.numPress('8');
                          },
                          text: '8',
                        ),
                        _Button(
                          onPressed: () {
                            model.numPress('9');
                          },
                          text: '9',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _Button(
                          onPressed: () {
                            model.totalDelete();
                          },
                          text: 'C',
                        ),
                        _Button(
                          onPressed: () {
                            model.numPress('0');
                          },
                          text: '0',
                        ),
                        _Button(
                          onPressed: () {
                            model.delete();
                          },
                          text: '⌫',
                        ),
                        // '⌫',
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RotesContainer extends StatelessWidget {
  final Color colorOfRatesWidget;
  final Color colorOfIconWidget;
  final String charCodeCurrency;
  final String valueField;
  final String nameCurrency;
  final Function() widgetFilling;
  final Function() choiceInputField;

  const _RotesContainer(
      {Key? key,
      required this.colorOfRatesWidget,
      required this.colorOfIconWidget,
      required this.charCodeCurrency,
      required this.valueField,
      required this.nameCurrency,
      required this.widgetFilling,
      required this.choiceInputField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Provider.of<ColorsTheme>(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Container(
          height: 90,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0, 0),
              end: const Alignment(3.4, 3),
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
                    charCodeCurrency,
                    style: const TextStyle(fontSize: 34),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 38,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1.4),
                      ),
                      child: TextButton(
                        onPressed: choiceInputField,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              valueField,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: color.colorOfTextBlack, fontSize: 20),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        nameCurrency,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CurrencyList(),
                        ),
                      );
                      widgetFilling();
                    },
                    splashRadius: 30,
                    //не ставить 0
                    icon: Icon(
                      color: colorOfIconWidget,
                      Icons.sync,
                    ),
                    iconSize: 38,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class _Button extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const _Button({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = Provider.of<ColorsTheme>(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(-2, 0),
                  end: const Alignment(5, 0),
                  colors: [
                    color.colorOfSecondButtonColor,
                    color.colorOfAppBar,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                constraints: const BoxConstraints(minHeight: 50),
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 26),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
