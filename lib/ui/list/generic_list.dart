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
      _items = items.reorder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            _list(),
            _clearButton()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: _show,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  Widget _clearButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: TextButton(
        onPressed: _clearList,
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontFamily: 'font', fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child: const Text('Clear'),
      ),
    );
  }

  Widget _list() {
    return Expanded(
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            leading: Checkbox(
              fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.blueAccent;  // Checked color
                }
                return Colors.white70;     // Unchecked color
              }),
              value: _items[index].checked,
              onChanged: (bool? newValue) {
                _checkItem(index, newValue ?? false);
              },
            ),
            title: Text(
              _items[index].title,
              style: const TextStyle(fontFamily: 'font'),
            ),
          );
        },
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
              contentPadding: EdgeInsets.all(20.0),
            ),
            onSubmitted: _addItem,
          ),
        ),
      )
    );
  }

  void _addItem(String item) {
    if (item.isEmpty) {
      return;
    }
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
    _items.reorder();
    setState(() {});
  }

  void _clearList() {
    // TODO: clear list in firestore
  }
}