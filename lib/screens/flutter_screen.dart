import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FlutterTestScreen extends StatefulWidget {
  @override
  _FlutterTestScreenState createState() => _FlutterTestScreenState();
}

class _FlutterTestScreenState extends State<FlutterTestScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _questionsCollection =
      FirebaseFirestore.instance.collection('questions');

  List<Map<String, dynamic>> flutterQuestions = [];
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  int score = 0;
  int score2 = 0;
  bool isTestCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadFlutterQuestions();
  }

  Future<void> _loadFlutterQuestions() async {
    await _questionsCollection
        .where('category', isEqualTo: 'Flutter')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        flutterQuestions.add(doc.data() as Map<String, dynamic>);
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Test Ekranı"),
      ),
      body: flutterQuestions.isNotEmpty
          ? _buildQuestionCard()
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildQuestionCard() {
    Map<String, dynamic> currentQuestion = flutterQuestions[currentQuestionIndex];
    bool isLastQuestion = currentQuestionIndex == flutterQuestions.length - 1;

    return QuestionCard(
      question: currentQuestion['question'],
      options: [
        currentQuestion['answer1'],
        currentQuestion['answer2'],
        currentQuestion['answer3'],
        currentQuestion['answer4'],
      ],
      selectedAnswerIndex: selectedAnswerIndex,
      onAnswerSelected: (int index) {
        if (!isTestCompleted) {
          setState(() {
            selectedAnswerIndex = index;
          });
        }
      },
      onNextPressed: () {
        if (!isTestCompleted) {
          _evaluateAnswer(currentQuestion);
          _moveToNextQuestion(isLastQuestion);
        }
      },
      buttonText: isLastQuestion ? "Testi Bitir" : "Sonraki Soru",
    );
  }

  void _evaluateAnswer(Map<String, dynamic> question) {
    if (selectedAnswerIndex == question['correctAnswer'] - 1) {
      score++;
      score2 = score * 10;
    }
  }

  void _moveToNextQuestion(bool isLastQuestion) {
    setState(() {
      selectedAnswerIndex = null;
      if (!isLastQuestion) {
        currentQuestionIndex++;
      } else {
        _showResult();
      }
    });
  }

  void _showResult() {
    setState(() {
      isTestCompleted = true;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Test Bitti."),
          content: Text("${flutterQuestions.length} sorudan $score tanesini doğru bildiniz.\n Puanınız: $score2"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }
}

class QuestionCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final int? selectedAnswerIndex;
  final Function(int) onAnswerSelected;
  final VoidCallback onNextPressed;
  final String buttonText;

  const QuestionCard({
    required this.question,
    required this.options,
    required this.selectedAnswerIndex,
    required this.onAnswerSelected,
    required this.onNextPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          for (int i = 0; i < options.length; i++)
            RadioListTile(
              title: Text(options[i]),
              value: i,
              groupValue: selectedAnswerIndex,
              onChanged: (value) {
                onAnswerSelected(value as int);
              },
            ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: onNextPressed,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FlutterTestScreen(),
  ));
}
