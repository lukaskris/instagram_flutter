import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:instagram/core/interceptor/token_interceptor.dart';
import 'package:instagram/core/models/base_response.dart';
import 'package:instagram/core/models/comment_service/comment_service.dart';
import 'package:instagram/core/models/failure.dart';
import 'package:instagram/core/models/post_service/post_service.dart';
import 'package:instagram/core/models/user.dart';
import 'package:instagram/core/network/dio_exception_source.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkService {
  final Dio _dio = Dio();
  static const String baseUrl = 'http://localhost:8080/api';

  NetworkService() {
    _dio.options.baseUrl = baseUrl; // Replace with your API base URL
    _dio.options.connectTimeout =
        const Duration(milliseconds: 5000); // 5 seconds
    _dio.options.receiveTimeout =
        const Duration(milliseconds: 3000); // 3 seconds

    // Add TokenInterceptor
    _dio.interceptors.add(TokenInterceptor());
    _dio.interceptors.add(PrettyDioLogger());
  }

  BaseApiResponse<T> _handleResponse<T>(
      Response response, T Function(dynamic) fromJsonT) {
    return BaseApiResponse<T>.fromJson(
        response.data as Map<String, dynamic>, fromJsonT);
  }

  Future<Either<Failure, BaseApiResponse<User>>> login(
      String email, String password) async {
    try {
      Response response = await _dio.post('/auth/login', data: {
        'username': email,
        'password': password,
      });
      return Right(
          _handleResponse<User>(response, (data) => User.fromJson(data)));
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, BaseApiResponse<List<PostService>>>> getPosts() async {
    try {
      Response response = await _dio.get('/posts');
      return Right(_handleResponse<List<PostService>>(
          response,
          (data) => (data as List<dynamic>)
              .map((e) => PostService.fromJson(e as Map<String, dynamic>))
              .toList()));
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, BaseApiResponse<PostService>>> likePost(
      String postId) async {
    try {
      Response response = await _dio.post('/likes', data: {
        'postId': postId,
      });
      return Right(_handleResponse<PostService>(response,
          (data) => PostService.fromJson(data as Map<String, dynamic>)));
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, BaseApiResponse<List<CommentService>>>> getComments(int postId) async {
    try {
      Response response = await _dio.get('/comments/$postId');
      return Right(_handleResponse<List<CommentService>>(
          response,
          (data) => (data as List<dynamic>)
              .map((e) => CommentService.fromJson(e as Map<String, dynamic>))
              .toList()));
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to fetch comments');
    }
  }

  Future<Either<Failure, BaseApiResponse<CommentService>>> sendComment(int postId, String text) async {
    try {
      Response response = await _dio.post('/comments', data: {
        'postId': postId,
        'text': text,
      });
      return Right(
          _handleResponse<CommentService>(response, (data) => CommentService.fromJson(data)));
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }  
  }
}
