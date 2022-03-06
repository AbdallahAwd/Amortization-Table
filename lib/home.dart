import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/components.dart';
import 'package:project/table.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var homeController = TextEditingController();
  var yearController = TextEditingController();
  var yearlyProfitController = TextEditingController();
  var dateController = TextEditingController();

  double loanValue = 0;
  double yearsNumber = 0;
  double monthlyRate = 0;
  double annuallyProfit = 0;
  double monthlyPayRate = 0;
  bool isChangeHouse = false;
  bool isChangeYears = false;
  bool isChangeProfit = false;
  bool isChangeDate = false;
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 50,
                        color: Colors.white,
                        offset: Offset(0, 15)),
                  ]),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 100,
                      ),
                      textWidget(
                          controller: homeController,
                          label: const Text('Enter house price'),
                          onChange: (value) {
                            setState(() {
                              loanValue = (double.parse(value) * 80 / 100);
                            });
                            isChangeHouse = true;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      textWidget(
                        controller: yearController,
                        label: const Text('Number of years'),
                        onChange: (value) {
                          setState(() {
                            yearsNumber = double.parse(value) * 12;
                            isChangeYears = true;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      textWidget(
                        controller: yearlyProfitController,
                        label: const Text('Annual Profit'),
                        onChange: (value) {
                          setState(() {
                            monthlyRate = double.parse(value) / 12;
                            isChangeProfit = true;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      textWidget(
                        controller: dateController,
                        label: const Text('Initial Date'),
                        onTab: () {
                          dateController.text = formattedDate;
                          setState(() {
                            isChangeDate = true;

                            monthlyPayRate = ((loanValue *
                                        (monthlyRate / 100)) *
                                    pow((1 + (monthlyRate / 100)),
                                        yearsNumber)) /
                                (pow((1 + (monthlyRate / 100)), yearsNumber) -
                                    1);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isChangeHouse
                          ? Text('Loan value is ${loanValue.toString()}')
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      isChangeYears
                          ? Text('Months Number is ${yearsNumber.toString()}')
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      isChangeProfit
                          ? Text(
                              'Monthly Profit Rate is ${monthlyRate.toStringAsFixed(2)}%')
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      isChangeDate
                          ? Text(
                              'Monthly pay is ${monthlyPayRate.toStringAsFixed(2)}')
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      isChangeDate
                          ? ElevatedButton(
                              child: const Text('To Table'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProjectTable(
                                              anuualRate:
                                                  yearlyProfitController.text,
                                              initialRate: dateController.text,
                                              loanValue: loanValue,
                                              monthlyRate: monthlyRate,
                                              numberOfPay: yearsNumber.toInt(),
                                              yeartermm: yearController.text,
                                              mortgagePayment: monthlyPayRate,
                                            )));
                              },
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
