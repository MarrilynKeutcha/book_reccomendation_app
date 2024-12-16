import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class GoogleBooksService {
  final String _apiKey = 'AIzaSyAAO5kXF8U-2Mx4cst8SH5x5N6qRju9OWw';

  Future<List<Book>> fetchBooks(String query) async {
    final response = await http.get(Uri.parse(
      'https://www.googleapis.com/books/v1/volumes?q=$query&key=$_apiKey',
    ));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['items'] as List).map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch books: ${response.reasonPhrase}');
    }
  }
}
