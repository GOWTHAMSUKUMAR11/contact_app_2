// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SortDetails extends StatefulWidget {
  bool valueName = true;
  bool valueId = true;
  bool valueCompanyName = false;
  final Function sort;

  SortDetails({
    super.key,
    required this.valueName,
    required this.valueId,
    required this.valueCompanyName,
    required this.sort,
  });

  @override
  State<SortDetails> createState() => _SortDetailsState();
}

class _SortDetailsState extends State<SortDetails> {
  void submit() {
    widget.sort(widget.valueName, widget.valueId, widget.valueCompanyName);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22.0),
      color: const Color.fromARGB(127, 249, 186, 61),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Text(
            'Select one or more options to sort',
            style: TextStyle(
              fontSize: 20.0,
              color: Color.fromARGB(255, 255, 170, 0),
              fontWeight: FontWeight.bold,
            ),
          ),
          CheckboxListTile(
            activeColor: const Color.fromARGB(255, 255, 170, 0),
            title: const Text(
              'Sort by name',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18.0,
              ),
            ),
            value: widget.valueName,
            onChanged: (bool? value) {
              setState(() {
                if (value != null) {
                  widget.valueName = value;
                }
              });
            },
          ),
          CheckboxListTile(
            activeColor: const Color.fromARGB(255, 255, 170, 0),
            title: const Text(
              'Sort by Id',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18.0,
              ),
            ),
            value: widget.valueId,
            onChanged: (bool? value) {
              setState(() {
                if (value != null) {
                  widget.valueId = value;
                }
              });
            },
          ),
          CheckboxListTile(
            activeColor: const Color.fromARGB(255, 255, 170, 0),
            title: const Text(
              'Sort by Company Name',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18.0,
              ),
            ),
            value: widget.valueCompanyName,
            onChanged: (bool? value) {
              setState(() {
                if (value != null) {
                  widget.valueCompanyName = value;
                }
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 249, 186, 61),
                  foregroundColor: Colors.white,
                ),
                onPressed: submit,
                child: const Text("Sort Details"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
