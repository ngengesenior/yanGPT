import 'dart:convert';
import 'dart:io';
import 'package:yangpt/models/Message.dart';
import 'package:yangpt/service/api_provider.dart';
import '../models/api_response.dart';
import 'package:http/http.dart';
class Networking {

  static String BASE_OPEN_API_URL = "https://api.openai.com/v1";
  final ApiProvider apiProvider;

  Networking({required this.apiProvider});


  Future<ApiResponse<String>> fetchOpenaiCodeCompletions(String prompt) async {
    final Map<String, dynamic> data = {
      'model': 'gpt-3.5-turbo',
      'prompt': prompt,
      'temperature': 0.4,
      'max_tokens': 256,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0,
    };
    final response = await apiProvider.post('$BASE_OPEN_API_URL/completions', data);
    return ApiResponse(statusCode: response.statusCode, body: response.body);

  }

  Future<ApiResponse<String>> getChatCompletion(String prompt) async {
    final data = {
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'user', 'content': prompt},
      ],
      'temperature': 0.7,
    };
    final response = await apiProvider.post('$BASE_OPEN_API_URL/chat/completions', data);
    return ApiResponse(statusCode: response.statusCode, body: response.body);

  }

  Future<ApiResponse<String>> getChatCompletion(List<Message> messages) {
    final data = {
      'model': 'gpt-3.5-turbo',
      'messages': messages.ma,
      'temperature': 0.7,
    };
  }
  
  Future<ApiResponse<String>> editImage(String prompt,File image) async {
    return await apiProvider.multipartRequest('$BASE_OPEN_API_URL/images/edits', image, prompt);
  }

  Future<ApiResponse<String>> generateImages(String prompt) async {
    final data = {
      'prompt':prompt,
      'n':1,
      'size':'512x512'
    };
    return await apiProvider.post('$BASE_OPEN_API_URL/images/generations',data);
  }


}