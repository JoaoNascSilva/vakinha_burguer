import 'package:vakinha_burguer_mobile/app/models/user_models.dart';

abstract class AuthRepository {
  Future<UserModels> register(String name, String email, String password);
  Future<UserModels> login(String email, String password);
}
