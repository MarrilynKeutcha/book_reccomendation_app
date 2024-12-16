import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/openai_service.dart';

class ReviewScreen extends StatefulWidget {
  final Book book;

  const ReviewScreen({super.key, required this.book});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final OpenAIService _openAIService = OpenAIService();
  final TextEditingController _reviewController = TextEditingController();
  String _reviewAnalysis = '';
  bool _isLoading = false;

  void _analyzeReview() async {
    setState(() => _isLoading = true);
    try {
      final analysis = await _openAIService.analyzeReview(_reviewController.text);
      setState(() => _reviewAnalysis = analysis);
    } catch (e) {
      setState(() => _reviewAnalysis = 'Error analyzing review: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review ${widget.book.title}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Write your review here...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _analyzeReview,
              child: const Text('Analyze Review'),
            ),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_reviewAnalysis.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Analysis: $_reviewAnalysis',
                  style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
