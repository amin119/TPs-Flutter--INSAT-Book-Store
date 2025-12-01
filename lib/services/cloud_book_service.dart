import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class CloudBookService {
  final CollectionReference _books = FirebaseFirestore.instance.collection('books');

  /// Stream of Book objects (real-time). Optionally filter by ownerId.
  Stream<List<Book>> streamBooks({String? ownerId}) {
    Query q = _books.orderBy('createdAt', descending: true);
    if (ownerId != null && ownerId.isNotEmpty) q = q.where('ownerId', isEqualTo: ownerId);
    return q.snapshots().map((snap) => snap.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          return Book.fromMap(data, id: d.id);
        }).toList());
  }

  /// Add a Book document to Firestore. Optionally associate with an ownerId (uid).
  Future<DocumentReference> addBook(Book book, {String? ownerId}) async {
    final doc = await _books.add({
      'name': book.name,
      'price': book.price,
      'image': book.image,
      'ownerId': ownerId ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    });
    return doc;
  }

  Future<void> deleteBook(String docId) async {
    await _books.doc(docId).delete();
  }
}
