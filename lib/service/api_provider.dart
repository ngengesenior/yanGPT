import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/api_response.dart';
class ApiProvider {
  http.Client client;
  ApiProvider ({required this.client});
  static const defaultHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer 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',
  };

  Future<ApiResponse<String>> post(String url, Map<String, dynamic> body,
      {Map<String, dynamic> headers = defaultHeaders}) async {
    try {
      Uri uri = Uri.parse(url);
      var response = await client.post(uri,
          body: jsonEncode(body), headers: defaultHeaders);
      return ApiResponse<String>(
          statusCode: response.statusCode, body: response.body);
    } catch (e) {
      return ApiResponse<String>(
          statusCode: 500,
          body: '{"message":"An unknown error occurred ${e.toString()}"}');
    }
  }

  Future<ApiResponse<String>> multipartRequest(String url,File image,String prompt) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.headers['Authorization'] = 'Bearer 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';
    request.fields['prompt'] = prompt;
    request.fields['n'] = '1';
    request.fields['size'] = '512x512';
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    final response = await request.send();
    try {
      final responseBody = await response.stream.bytesToString();
      return ApiResponse(statusCode: HttpStatus.ok, body: responseBody);
    }catch(e) {
      return ApiResponse(statusCode: 500, body: '{"message":"An unknown error occurred ${e.toString()}"}');
    }
  }
}


