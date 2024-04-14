import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreenWeb extends StatefulWidget {
  const SearchScreenWeb({super.key});

  @override
  State<SearchScreenWeb> createState() => _SearchScreenWebState();
}

class _SearchScreenWebState extends State<SearchScreenWeb> {
  final TextEditingController _controller = TextEditingController();
  String _response = 'Your answer will appear here'; // Default text

  // Function to fetch the answer from the API
  Future<void> fetchAnswer() async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/get-answer/'), // Your API Endpoint
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'user_query': _controller.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _response = data['answer']; // Assuming 'answer' is the key in the JSON response
      });
    } else {
      // Handle errors or unsuccessful responses
      setState(() {
        _response = 'Failed to get the answer. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row( // Using Row to create two columns
        children: <Widget>[
          Expanded(
            flex: 1, // ensures equal space distribution
            child: Column( // Left column
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Talk to your Database', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/a.jpeg', // Correct the file extension if necessary
                    width: 410, // Width of the image
                    height: 410, // Height of the image
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1, // ensures equal space distribution
            child: Padding( // Right column
              padding: const EdgeInsets.fromLTRB(20,300,50,20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your query here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: fetchAnswer,
                    child: const Text('Get Answer'),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(_response),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
