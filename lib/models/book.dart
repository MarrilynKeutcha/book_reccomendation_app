class Book {
  final String title;
  final String author;
  final String description;
  final String imageUrl;

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['volumeInfo']['title'] ?? 'No Title',
      author: (json['volumeInfo']['authors'] as List<dynamic>?)?.join(', ') ?? 'Unknown Author',
      description: json['volumeInfo']['description'] ?? 'No Description',
      imageUrl: json['volumeInfo']['imageLinks']?['thumbnail'] ?? '',
    );
  }
}
