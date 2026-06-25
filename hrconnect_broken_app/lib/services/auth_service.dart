import '../data/mock_hr_data.dart';
import '../models/app_user.dart';

class AuthService {
  const AuthService();

  AppUser? login(String email, String password) {
    final normalizedEmail = email.trim().toLowerCase();
    for (final user in mockUsers) {
      final userEmail = (user['email'] as String).toLowerCase();
      final userPassword = user['password'] as String;
      if (userEmail == normalizedEmail && userPassword == password) {  // Changed || to &&
        return AppUser.fromJson(user);
      }
    }
    return null;
  }
}
