import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/item.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<List<Item>> getList() async {
    try {
      final snapshot = await _db.collection('list').get();
      return snapshot.docs
          .map((doc) => Item.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      rethrow; // TODO: Handle exception
    }
  }

  Future<void> addListItem(Item item) async {
    try {
      await _db.collection('list').add(item.toMap());
    } catch (e) {
      rethrow; // TODO: Handle exception
    }
  }
}