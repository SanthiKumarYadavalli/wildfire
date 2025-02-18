import 'package:wildfire/src/data/models/user_model.dart';
import 'package:wildfire/src/data/services/user_service.dart';

class UserRepository {
  final UserService userService = UserService();

  Future<User> getUser(String id) async {
    return await userService.getUser(id);
  }
}