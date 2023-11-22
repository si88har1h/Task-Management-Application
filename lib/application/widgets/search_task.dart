import 'package:flutter/material.dart';

class SearchTask extends StatefulWidget {
  const SearchTask({required this.onSearchTextChanged, super.key});
  final Function(String) onSearchTextChanged;

  @override
  State<SearchTask> createState() => _SearchTaskState();
}

class _SearchTaskState extends State<SearchTask> {
  final TextEditingController searchControlller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: searchControlller,
      decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 115, 92)),
          ),
          hintText: 'Search Tasks..',
          hintStyle: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          )),
      onChanged: (text) {
        widget.onSearchTextChanged(text);
      },
    );
  }
}
