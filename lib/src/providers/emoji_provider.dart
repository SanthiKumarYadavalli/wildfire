import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emoji_provider.g.dart';


@riverpod
class Emoji extends _$Emoji {
  @override
  String build() {
    return "😢";
  }

  void setEmoji(String emoji) {
    state = emoji;
  }
}