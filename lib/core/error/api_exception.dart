class ApiException implements Exception {
  final String message;
  final int? errorCode;
  final String? url;
  final int? statusCode;

  ApiException(this.message, {this.errorCode, this.url, this.statusCode});

  @override
  String toString() {
    final buffer = StringBuffer('ApiException: $message');
    if (errorCode != null) buffer.write(' (Code: $errorCode)');
    if (url != null) buffer.write(' URL: $url');
    if (statusCode != null) buffer.write(' Status: $statusCode');
    return buffer.toString();
  }
}