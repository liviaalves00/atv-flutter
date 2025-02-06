import 'package:projeto_final_fltter/src/models/user_model.dart';
import 'package:projeto_final_fltter/src/repositories/user_repository.dart';

class AuthController {
  final userRepository = UserRepository();

  Future<bool> registerUser(String email, String password) async {
    final user = User(email: email, password: password);
    await userRepository.insertUser(user);
    return true;
  }

  Future<bool> loginUser(String email, String password) async {
    final users = await userRepository.users();
    for (var user in users) {
      if (user.email == email && user.password == password) {
        return true;
      }
    }

    return false;
  }
}
