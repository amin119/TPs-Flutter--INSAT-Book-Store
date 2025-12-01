import '../models/book.dart';
import 'database_helper.dart';

class BookService {
  final DatabaseHelper _helper = DatabaseHelper();

  /// insert a book into the basket table; optionally associate to a user email
  Future<int> insertBook(Book book, {String? userEmail}) async {
    final db = await _helper.database;
    final id = await db.insert('book', {
      'name': book.name,
      'price': book.price,
      'image': book.image,
      'user_email': userEmail,
    });
    return id;
  }

  /// fetch books in the basket; if userEmail provided, filter by it
  Future<List<Book>> fetchBasketBooks({String? userEmail}) async {
    final db = await _helper.database;
    List<Map<String, Object?>> rows;
    if (userEmail != null) {
      rows = await db.query('book', where: 'user_email = ?', whereArgs: [userEmail]);
    } else {
      rows = await db.query('book');
    }

    return rows.map((r) => Book(r['name'] as String, (r['price'] as num).toInt(), r['image'] as String)).toList();
  }

  /// clear basket (useful for testing)
  Future<int> clearBasket() async {
    final db = await _helper.database;
    return await db.delete('book');
  }
}
