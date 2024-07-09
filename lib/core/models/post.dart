import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  final String description;
  final String uid;
  final String username;
  final int likes;
  final int totalComments;
  final int postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final bool isLike;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.totalComments,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.isLike,
  });

  @override
  List<Object?> get props => [
        description,
        uid,
        username,
        postId,
        datePublished,
        postUrl,
        profImage,
        isLike,
      ];

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
