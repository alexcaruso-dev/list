import 'package:flutter/material.dart';

class GenericList extends StatefulWidget {
  const GenericList({super.key});

  @override
  State<StatefulWidget> createState() => _GenericListState();
}

class _GenericListState extends State<GenericList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add)
      ),
    );
  }
}