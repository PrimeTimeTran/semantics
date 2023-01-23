import 'package:flutter/material.dart';

const List<String> list = <String>[
  'Vietnamese 🇻🇳',
  'Spanish 🇪🇸',
  'Chinese 🇨🇳'
];

Map<String, String> languages = {
  "vi": 'Vietnamese 🇻🇳',
  "es": 'Spanish 🇪🇸',
  "zh": 'Chinese 🇨🇳'
};

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key, required this.changeLanguage});

  final Function changeLanguage;

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.lightBlueAccent,
      ),
      onChanged: (String? value) {
        widget.changeLanguage(value);
        setState(() {
          dropdownValue = value!;
        });
      },
      // TODO: Fix this so that it uses a Map instead of List.
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
