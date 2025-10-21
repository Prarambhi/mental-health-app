import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding and decoding

class Quiz1 extends StatefulWidget {
  final String username; // Add username as a field

  const Quiz1({super.key, required this.username}); 

  @override
  Quiz1State createState() => Quiz1State();
}

class Quiz1State extends State<Quiz1> {
  // Access the username via widget.username
  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'Sleep: Frequency of sleep disturbances',
      'options': [
        'Never',
        'Always',
        'Often',
        'Rarely',
        'Sometimes',
        'Not at all'
      ]
    },
    {
      'questionText': 'Appetite: Changes in appetite',
      'options': [
        'Never',
        'Always',
        'Often',
        'Rarely',
        'Sometimes',
        'Not at all'
      ]
    },
    // Additional questions...
  ];

  final Map<String, Map<int, int>> _selectedAnswers = {}; // Change to use username as key
  int _currentQuestionIndex = 0;
  int _totalScore = 0; 
  String _result = '';
  bool _isLoading = false;
  bool _isSubmitted = false; // Track if the quiz is submitted

  @override
  void initState() {
    super.initState();
    // Initialize the user's answer map if needed
    _selectedAnswers[widget.username] = {};
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      _selectedAnswers[widget.username]![_currentQuestionIndex] = answerIndex; // Store answer with current question index
    });
  }

  void _nextQuestion() {
    if (_selectedAnswers[widget.username]!.containsKey(_currentQuestionIndex)) {
      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
        });
      } else {
        _submitQuiz();
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("No Answer Selected"),
          content: const Text("Please select an answer before proceeding."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _submitQuiz() async {
    setState(() {
      _isLoading = true;
    });

    List<int> answers = _selectedAnswers[widget.username]!.values.toList(); // Get answers for this username
    _totalScore = _selectedAnswers[widget.username]!.entries.fold(0, (sum, entry) {
      return sum + entry.value; // Assuming index represents score
    });

    try {
      var response = await http.post(
        Uri.parse('https://your-backend-url.com/predict'), // Replace with your backend URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'answers': answers, 'total_score': _totalScore}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          _result = jsonResponse['prediction'];
          _isLoading = false;
          _isSubmitted = true;
        });
      } else {
        _showErrorDialog('Error', 'Failed to get a response from the server.');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      _showErrorDialog('Error', 'Could not submit the quiz. Please try again.');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Health Quiz'),
        backgroundColor: const Color.fromARGB(255, 111, 164, 130),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: _isSubmitted
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Your result is: $_result\nTotal Score: $_totalScore', 
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _currentQuestionIndex = 0;
                              _selectedAnswers[widget.username]!.clear(); // Clear answers for this user
                              _isSubmitted = false;
                              _totalScore = 0; 
                            });
                          },
                          child: const Text('Restart Quiz'),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q${_currentQuestionIndex + 1}: ${_questions[_currentQuestionIndex]['questionText']}', 
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        ...(_questions[_currentQuestionIndex]['options'] as List<String>).map((option) {
                          int optionIndex = (_questions[_currentQuestionIndex]['options'] as List<String>).indexOf(option);
                          return RadioListTile<int>(
                            title: Text(option),
                            value: optionIndex,
                            groupValue: _selectedAnswers[widget.username]?[_currentQuestionIndex],
                            onChanged: (value) => _selectAnswer(value!),
                          );
                        }),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _nextQuestion,
                          child: Text(_currentQuestionIndex == _questions.length - 1 ? 'Submit' : 'Next'),
                        ),
                      ],
                    ),
            ),
    );
  }
}
