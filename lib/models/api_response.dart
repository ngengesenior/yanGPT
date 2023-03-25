import 'dart:convert';


class ApiResponse<T>{
  int statusCode;
  T body;

  ApiResponse({required this.statusCode, required this.body});

  isOk() {
    return statusCode == 200;
  }

  isCreated() {
    return statusCode == 201;
  }

  isBadRequest() {
    return statusCode == 400;
  }

  isNotFound() {
    return statusCode == 404;
  }

  isConflict() {
    return statusCode == 409;
  }

  isServerError() {
    return statusCode == 500;
  }

  isSuccess() {
    return statusCode >= 200 && statusCode < 300;
  }

  /// For errors such as 400,401,404,409,500 from the Bongalo API, the error body has the
  /// error message in the message key
  String retrieveErrorFromResponse() {
    String error;
    switch (statusCode) {
      case 400:
      case 401:
      case 404:
      case 409:
      case 500:
        String bodyAsString = body as String;
        Map<String, dynamic> errorBody =
        jsonDecode(bodyAsString).cast<String, dynamic>();
        error = errorBody['message'];
        break;
      default:
        error = jsonEncode({'message': 'An unknown error occurred'});
    }
    return error;
  }
}
