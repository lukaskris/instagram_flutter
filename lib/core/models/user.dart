import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String? email;
  final String profilePicture;
  final String username;
  final String? bio;
  final String token;
  final List? followers;
  final List? following;

  const User({
    required this.username,
    required this.profilePicture,
    required this.email,
    required this.bio,
    required this.followers,
    required this.token,
    required this.following,
  });

  @override
  List<Object?> get props =>
      [username, email, profilePicture, followers, following, token];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
