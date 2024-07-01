import 'package:dio/dio.dart';
import 'package:instagram/core/models/base_response.dart';
import 'package:instagram/core/models/user.dart';

class NetworkService {
  final Dio _dio = Dio();

  NetworkService() {
    _dio.options.baseUrl =
        'http://localhost:8080/api'; // Replace with your API base URL
    _dio.options.connectTimeout =
        const Duration(milliseconds: 5000); // 5 seconds
    _dio.options.receiveTimeout =
        const Duration(milliseconds: 3000); // 3 seconds
  }

  BaseApiResponse<T> _handleResponse<T>(
      Response response, T Function(dynamic) fromJsonT) {
    return BaseApiResponse<T>.fromJson(
        response.data as Map<String, dynamic>, fromJsonT);
  }

  Future<BaseApiResponse<User>> login(String email, String password) async {
    try {
      Response response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });
      return _handleResponse<User>(response, (data) => User.fromJson(data));
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Login failed');
    }
  }

  Future<BaseApiResponse<List<dynamic>>> getPosts() async {
    try {
      Response response = await _dio.get('/posts');
      return _handleResponse<List<dynamic>>(
          response, (data) => data as List<dynamic>);
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to fetch posts');
    }
  }

  Future<BaseApiResponse<List<dynamic>>> getComments(String postId) async {
    try {
      Response response = await _dio.get('/posts/$postId/comments');
      return _handleResponse<List<dynamic>>(
          response, (data) => data as List<dynamic>);
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to fetch comments');
    }
  }
}
