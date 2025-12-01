import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserService {
  static const _kEmail = 'current_user_email';
  static const _kName = 'current_user_name';

  /// Save the current user to SharedPreferences
  Future<void> saveCurrentUser(User user) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kEmail, user.email);
    await sp.setString(_kName, user.fullName);
    // C tt simpelment pour le testing 
    print('User Saved Successfully: ${user.email} / ${user.fullName}');
  }

  /// Return the current user if present, otherwise null
  Future<User?> getCurrentUser() async {
    final sp = await SharedPreferences.getInstance();
    final email = sp.getString(_kEmail);
    final name = sp.getString(_kName);
    if (email == null && name == null) return null;
    return User(email: email ?? '', fullName: name ?? '');
  }

  /// Clear stored current user
  Future<void> clearCurrentUser() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kEmail);
    await sp.remove(_kName);
  }
}


/* 
SharedPreferences.getInstance() : methode qui retourne un future sharedpreferences
async : on l'utilise pour indiquer que la fonction est asynchrone et retourne un future
await : on l'ajoute pour attendre la resolution d'un future avant de continuer l'execution
*/