import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreenWeb extends StatefulWidget {
  const SearchScreenWeb({Key? key}) : super(key: key);

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
      appBar: AppBar(title: const Text('LLM Query')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter your query here',
                border: OutlineInputBorder(),
                // suffixIcon: IconButton(
                //   icon: Icon(Icons.clear),
                //   onPressed: () => _controller.clear() ,
                // ),
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
    );
  }
}