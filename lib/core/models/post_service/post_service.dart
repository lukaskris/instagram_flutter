import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_service.g.dart';

@JsonSerializable()
class PostService extends Equatable {
  final String? content;
  final String? username;
  final String? profilePicture;
  final DateTime? createdAt;
  final List<String>? images;
  final int? totalLikes;
  final int? likedByUser;
  final int? totalComments;
  final int? postId;

  const PostService({
    this.content,
    this.createdAt,
    this.images,
    this.totalLikes,
    this.likedByUser,
    this.totalComments,
    this.postId,
    this.username,
    this.profilePicture,
  });

  factory PostService.fromJson(Map<String, dynamic> json) {
    return _$PostServiceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PostServiceToJson(this);

  PostService copyWith({
    String? content,
    String? profilePicture,
    String? username,
    DateTime? createdAt,
    List<String>? images,
    int? totalLikes,
    int? likedByUser,
    int? totalComments,
    int? postId,
  }) {
    return PostService(
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      images: images ?? this.images,
      totalLikes: totalLikes ?? this.totalLikes,
      likedByUser: likedByUser ?? this.likedByUser,
      totalComments: totalComments ?? this.totalComments,
      postId: postId ?? this.postId,
      profilePicture: profilePicture ?? this.profilePicture,
      username: username ?? this.username,
    );
  }

  @override
  List<Object?> get props {
    return [
      content,
      createdAt,
      images,
      totalLikes,
      likedByUser,
      totalComments,
      postId,
      profilePicture,
      username,
    ];
  }
}
