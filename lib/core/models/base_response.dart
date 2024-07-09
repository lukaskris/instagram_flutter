class BaseApiResponse<T> {
  final String detail;
  final T data;

  BaseApiResponse({
    required this.detail,
    required this.data,
  });

  factory BaseApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      BaseApiResponse<T>(
        detail: json['message'] as String,
        data: fromJsonT(json['data']),
      );
}
