// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      description: json['description'] as String,
      uid: json['uid'] as String,
      username: json['username'] as String,
      likes: (json['likes'] as num).toInt(),
      postId: json['postId'] as String,
      datePublished: DateTime.parse(json['datePublished'] as String),
      postUrl: json['postUrl'] as String,
      profImage: json['profImage'] as String,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'description': instance.description,
      'uid': instance.uid,
      'username': instance.username,
      'likes': instance.likes,
      'postId': instance.postId,
      'datePublished': instance.datePublished.toIso8601String(),
      'postUrl': instance.postUrl,
      'profImage': instance.profImage,
    };
