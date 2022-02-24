class ErrorHandler {
  //message about the error thwron
  final String message;

  // constructor
  ErrorHandler(this.message);

  @override
  String toString() {
    return message;
  }
}

/**
 * 3 types of exceptions :
 * - SocketException : No Internet Connection
 * - HttpException : can't find the datas (example : code 404)
 * - FormatException : wrong format of datas (example : missing '{' in JSON syntax)
 */