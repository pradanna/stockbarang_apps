import 'package:flutter/material.dart';

class Searchfield extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String hintText;

  const Searchfield({
    Key? key,
    this.onChanged,
    this.hintText = 'Search...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50), // Rounded full
        border: Border.all(
          color: Colors.black12, // Thin border
          width: 1,
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none, // No default border
          icon: Icon(Icons.search, color: Colors.grey), // Search icon
        ),
      ),
    );
  }
}
