enum StateStatus {
  initial,
  loading,
  success,
  failure,
}

extension StateStatusX on StateStatus {
  bool get isLoading => this == StateStatus.loading;
  bool get isSuccess => this == StateStatus.success;
  bool get isFailure => this == StateStatus.failure;
}
