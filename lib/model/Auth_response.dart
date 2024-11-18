class ApiResponse {
  final bool status;
  final String? message;
  final String? token;

  ApiResponse({
    required this.status,
    this.message,
    this.token,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'] ?? false,
      message: json['message'],
      token: json['token'],
    );
  }
}
