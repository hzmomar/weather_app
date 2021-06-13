class ErrorModel {
  int? code;
  String? message;

  ErrorModel({
    this.code,
    this.message,
  });

  ErrorModel.fromJson(Map<String, dynamic> map) {
    code = map['cod'] as int;
    message = map['message'] as String;
  }

  @override
  String toString() {
    return 'ErrorModel{code: $code, message: $message}';
  }
}
