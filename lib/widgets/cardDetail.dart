import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardDetails extends StatelessWidget {
  String name;
  String value;
  CardDetails({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        width: 150,
        child: Text(
          name,
          style: const TextStyle(
            color: Color.fromARGB(127, 249, 186, 61),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Flexible(
        child: Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ]);
  }
}
