class Item {
  String? id;
  String title;
  bool checked;

  Item({this.id, required this.title, this.checked = false});

  factory Item.fromFirestore(String id, Map<String, dynamic> data) {
    return Item(
      id: id,
      title: data['title'] ?? '',
      checked: data['checked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'checked': checked,
    };
  }
}

extension ItemExtension on List<Item> {
  List<Item> reorder() {
    sort((a, b) {
      if (a.checked == b.checked) return 0;
      return a.checked ? 1 : - 1;
    });
    return this;
  }
}