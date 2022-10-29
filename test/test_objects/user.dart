// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  @Assert("id != '' ", 'id cannot be empty')
  @Assert("name != '' ", 'name cannot be empty')
  @Assert('age >= 0 && age <= 100')
  const factory User({
    required String id,
    required String name,
    required int age,
    String? avatarURL,
  }) = _User;
}
