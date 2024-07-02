// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostService _$PostServiceFromJson(Map<String, dynamic> json) => PostService(
      content: json['content'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      totalLikes: (json['totalLikes'] as num?)?.toInt(),
      likedByUser: json['likedByUser'],
      totalComments: (json['totalComments'] as num?)?.toInt(),
      postId: (json['postId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PostServiceToJson(PostService instance) =>
    <String, dynamic>{
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
      'images': instance.images,
      'totalLikes': instance.totalLikes,
      'likedByUser': instance.likedByUser,
      'totalComments': instance.totalComments,
      'postId': instance.postId,
    };
