import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Ensure an anonymous session exists and return the Firebase User.
  Future<User?> signInAnonymouslyIfNeeded() async {
    final current = _auth.currentUser;
    if (current != null) return current;
    final cred = await _auth.signInAnonymously();
    return cred.user;
  }

  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async => _auth.signOut();
}
