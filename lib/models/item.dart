class Item {
  String title;
  bool checked;

  Item({required this.title, this.checked = false});

  factory Item.fromFirestore(Map<String, dynamic> data) {
    return Item(
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