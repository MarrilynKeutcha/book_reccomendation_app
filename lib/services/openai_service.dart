import 'package:dio/dio.dart';

class OpenAIService {
  final Dio _dio = Dio();

  Future<String> analyzeReview(String review) async {
    final response = await _dio.post(
      'http://127.0.0.1:5000/analyze-review', 
      data: {'review': review},
    );
    return response.data['summary'];
  }
}
