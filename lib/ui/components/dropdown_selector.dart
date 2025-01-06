import 'package:flutter/material.dart';

class DropdownSelector extends StatefulWidget {
  const DropdownSelector({required this.items, required this.onChanged, super.key});

  final List<String> items;
  final Function onChanged;

  @override
  State<DropdownSelector> createState() => _DropdownSelectorState();
}

class _DropdownSelectorState extends State<DropdownSelector> {

  late String _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _selectedItem,
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          _selectedItem = value!;
        });
        widget.onChanged(value);
      },
    );
  }
}
