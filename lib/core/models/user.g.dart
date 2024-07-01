// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      username: json['username'] as String,
      uid: json['uid'] as String,
      photoUrl: json['photoUrl'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String,
      followers: json['followers'] as List<dynamic>,
      token: json['token'] as String,
      following: json['following'] as List<dynamic>,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'uid': instance.uid,
      'photoUrl': instance.photoUrl,
      'username': instance.username,
      'bio': instance.bio,
      'token': instance.token,
      'followers': instance.followers,
      'following': instance.following,
    };
