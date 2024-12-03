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
          onPressed: show,
          child: const Icon(Icons.add)
      ),
    );
  }

  void show() {
    showModalBottomSheet(
      context: context,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          child: const SizedBox(
            height: 200, // Set your desired height
            child: Center(
              child: TextField(autofocus:true),
            ),
          )
        ));
  }
}