import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_service.freezed.dart';
part 'comment_service.g.dart';

@freezed
class CommentService with _$CommentService {
  factory CommentService({
    int? id,
    String? username,
    String? profilePicture,
    String? text,
    DateTime? createdAt,
  }) = _CommentService;

  factory CommentService.fromJson(Map<String, dynamic> json) =>
      _$CommentServiceFromJson(json);
}
