import 'package:flutter/material.dart';

class GenericList extends StatefulWidget {
  const GenericList({super.key});

  @override
  State<StatefulWidget> createState() => _GenericListState();
}

class _GenericListState extends State<GenericList> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<String> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: _show,
          child: const Icon(Icons.add)
      ),
    );
  }

  void _show() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          width: double.infinity,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: true,
            maxLines: null,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Add a new item',
              contentPadding: EdgeInsets.all(20.0),
            ),
            onSubmitted: _addItem,
          ),
        ),
      )
    );
  }

  void _addItem(String item) {
    setState(() {
      _items.add(item);
      _controller.clear();
      _focusNode.requestFocus();
    });
  }
}