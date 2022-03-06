import 'package:flutter/material.dart';

Widget textWidget({
  var controller = TextEditingController,
  var onChange,
  var onTab,
  Widget? label,
}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        label: label,
      ),
      keyboardType: TextInputType.number,
      onChanged: onChange,
      onTap: onTab,
    );

TableRow tableBuilder(List<String> cells, {bool isHeader = false}) {
  return TableRow(
      children: cells.map((cell) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: isHeader
            ? Text(
                cell,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              )
            : Text(cell),
      ),
    );
  }).toList());
}
