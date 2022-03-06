// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components.dart';

class ProjectTable extends StatefulWidget {
  final loanValue;
  final yeartermm;
  final anuualRate;
  final initialRate;
  final int numberOfPay;
  final double monthlyRate;
  final double mortgagePayment;

  ProjectTable(
      {Key? key,
      required this.loanValue,
      required this.anuualRate,
      required this.initialRate,
      required this.monthlyRate,
      required this.numberOfPay,
      required this.mortgagePayment,
      required this.yeartermm})
      : super(key: key);

  @override
  State<ProjectTable> createState() => _ProjectTableState();
}

class _ProjectTableState extends State<ProjectTable> {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<double> startBalance = [];
  late double payment;
  List<double> interest = [];
  List<int> months = [1];
  List<double> principal = [];
  List<double> endingBalance = [];
  @override
  void initState() {
    super.initState();
    startBalance = [widget.loanValue];
    payment = widget.mortgagePayment;

    for (int i = 0; i <= widget.numberOfPay; i++) {
      interest.add(startBalance[i] * (widget.monthlyRate) / 100);
      principal.add(payment - interest[i]);
      endingBalance.add(startBalance[i] - principal[i]);
      months.add(i + 2);
      startBalance.add(endingBalance[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text(
          'Table',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Table(
                    border: TableBorder.all(),
                    children: [
                      tableBuilder([
                        'Principal',
                        'Term',
                        'Annual Rate',
                        'Initial Date',
                        'Number of Payment',
                        'Monthly Rate',
                        'Mortgage Payment'
                      ], isHeader: true),
                      tableBuilder([
                        '${widget.loanValue} \$',
                        '${widget.yeartermm} Year',
                        '${widget.anuualRate} %',
                        widget.initialRate,
                        '${widget.numberOfPay} Month',
                        '${widget.monthlyRate.toStringAsFixed(2)} %',
                        '${widget.mortgagePayment.toStringAsFixed(2)} L.E'
                      ]),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Table(
                  border: TableBorder.all(),
                  children: [
                    tableBuilder([
                      'Months',
                      'Date',
                      'Begining Balance',
                      'Payment',
                      'interest',
                      'Principal',
                      'Ending Balance',
                    ], isHeader: true),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 300,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Table(
                        border: TableBorder.all(),
                        children: [
                          tableBuilder([
                            '${months[index]}',
                            '${widget.initialRate}',
                            '${startBalance[index].toStringAsFixed(2)}\$',
                            '${payment.toStringAsFixed(2)}\$',
                            '${interest[index].toStringAsFixed(2)} \$',
                            '${principal[index].toStringAsFixed(2)}\$',
                            '${endingBalance[index].toStringAsFixed(2)} \$',
                          ]),
                        ],
                      );
                    },
                    itemCount: widget.numberOfPay,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
