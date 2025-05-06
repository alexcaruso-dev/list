import 'package:flutter/material.dart';
import 'package:list/firebase/firestore_service.dart';
import 'package:list/models/item.dart';

class GenericList extends StatefulWidget {
  const GenericList({super.key});

  @override
  State<StatefulWidget> createState() => _GenericListState();
}

class _GenericListState extends State<GenericList> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  Future<void> _loadList() async {
    var items = await _firestoreService.getList();
    setState(() {
      _items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return ListTile(
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  leading: Checkbox(
                      value: _items[index].checked,
                      onChanged: (bool? newValue) {
                        _checkItem(index, newValue ?? false);
                      }),
                  title: Text(_items[index].title));
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _show,
          child: const Icon(Icons.add)
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      _items.add(Item(title: item));
      _firestoreService.addListItem(Item(title: item));
      _controller.clear();
      _focusNode.requestFocus();
    });
  }

  void _checkItem(int index, bool checked) {
    final item = _items[index]..checked = checked;
    _firestoreService.updateListItem(item);
    setState(() {});
  }
}