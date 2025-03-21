import 'package:wildfire/src/data/models/user_model.dart';
import 'package:wildfire/src/data/services/user_service.dart';

class UserRepository {
  final UserService userService = UserService();

  Future<User> getUser(String id) async {
    final userData = await userService.getUser(id);
    return User(
      id: userData['_id'],
      username: userData['username'],
      email: userData['email'],
      name: userData['name'],
      profileImageUrl: userData['profilePic'],
    );
  }

  Future<String> updateName(id, newName) async {
    return (await userService.updateUser(id, {'name': newName}))['name'];
  }

  Future<String> updateProfileImage(id, image) async {
    return (await userService.updateUser(id, {'image': image}))['profilePic'];
  }
}