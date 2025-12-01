import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:insat_store/models/user.dart';
import 'package:insat_store/services/user_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UserService (SharedPreferences) tests', () {
    final service = UserService();

    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('save and get current user', () async {
      final user = User(email: 'eya.mhamdi@example.tn', fullName: 'Eya Mhamdi');

      await service.saveCurrentUser(user);

      final loaded = await service.getCurrentUser();
      expect(loaded, isNotNull);
      expect(loaded!.email, equals(user.email));
      expect(loaded.fullName, equals(user.fullName));
    });

    test('clear current user', () async {
      final user = User(email: 'nour.ayari@example.tn', fullName: 'Nour Ayari');
      await service.saveCurrentUser(user);

      var loaded = await service.getCurrentUser();
      expect(loaded, isNotNull);

      await service.clearCurrentUser();

      loaded = await service.getCurrentUser();
      expect(loaded, isNull);
    });
  });
}
