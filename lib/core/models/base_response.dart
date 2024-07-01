class BaseApiResponse<T> {
  final String detail;
  final int status;
  final T data;

  BaseApiResponse({
    required this.detail,
    required this.status,
    required this.data,
  });

  factory BaseApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic? json) fromJsonT,
  ) =>
      BaseApiResponse<T>(
        detail: json['detail'] as String,
        status: json['status'] as int,
        data: fromJsonT(json['data']),
      );
}
