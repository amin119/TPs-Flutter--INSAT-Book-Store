import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class FirestoreService {
  FirestoreService._privateConstructor();
  static final FirestoreService instance = FirestoreService._privateConstructor();

  final CollectionReference<Map<String, dynamic>> _booksRef =
      FirebaseFirestore.instance.collection('books');

  Stream<List<Book>> booksStream() {
    return _booksRef.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Book.fromMap(doc.data(), id: doc.id))
        .toList());
  }

  Future<void> addBook(Book book) async {
    await _booksRef.add(book.toMap());
  }

  Future<void> deleteBook(String id) async {
    await _booksRef.doc(id).delete();
  }
}
