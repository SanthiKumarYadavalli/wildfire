import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wildfire/src/data/models/user_model.dart';
import 'package:wildfire/src/data/repositories/user_repository.dart';
import 'package:wildfire/src/providers/auth_provider.dart';

part 'user_provider.g.dart';

@riverpod
class CurrUser extends _$CurrUser {
  final UserRepository _userRepository = UserRepository();
  @override
  FutureOr<User?> build() async {
    final token = ref.read(authProvider).requireValue;
    if (token != '') {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final theUser = await _userRepository.getUser(decodedToken['id']);
      return theUser;
    }
    return null;
  }
}