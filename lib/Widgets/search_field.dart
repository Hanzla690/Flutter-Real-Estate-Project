import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: const Color(0xffF8FAFC),
        hintText: "Search...",
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.filter_alt_rounded),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2,
              color: Colors.green.shade500),
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    );
  }
}
