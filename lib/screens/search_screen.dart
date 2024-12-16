import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/book.dart';
import 'book_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _books = [];
  bool _isLoading = false;

  Future<void> _searchBooks(String query) async {
    final url =
        "https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=10";

    setState(() {
      _isLoading = true;
      _books = [];
    });

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _books = data['items'] ?? [];
        });
      } else {
        throw Exception("Failed to load books");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Books"),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Enter book title or author",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _searchBooks(_controller.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Search"),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  final bookData = _books[index]['volumeInfo'];
                  final book = Book(
                    title: bookData['title'] ?? 'No Title',
                    author: (bookData['authors'] as List<dynamic>?)
                            ?.join(', ') ??
                        'Unknown Author',
                    description: bookData['description'] ?? 'No Description',
                    imageUrl: bookData['imageLinks']?['thumbnail'] ?? '',
                  );

                  return ListTile(
                    leading: book.imageUrl.isNotEmpty
                        ? Image.network(
                            book.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.book, size: 50),
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsScreen(book: book),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
