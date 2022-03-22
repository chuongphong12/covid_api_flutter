class Failure {
  String code;
  String message;

  Failure({required this.code, required this.message});

  @override
  String toString() {
    return 'Failure{code: $code, message: $message}';
  }
}
