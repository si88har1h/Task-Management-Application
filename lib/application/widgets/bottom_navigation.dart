import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.timelapse),
            onPressed: null,
            tooltip: 'Pending',
          ),
          IconButton(
            icon: Icon(Icons.done),
            onPressed: null,
            tooltip: 'Completed',
          )
        ],
      ),
    );
  }
}
