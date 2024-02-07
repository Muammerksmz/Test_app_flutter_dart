import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionUpdateScreen extends StatefulWidget {
  @override
  _QuestionUpdateScreenState createState() => _QuestionUpdateScreenState();
}

class _QuestionUpdateScreenState extends State<QuestionUpdateScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _questionsCollection =
      FirebaseFirestore.instance.collection('questions');

  List<QueryDocumentSnapshot> questions = [];
  String selectedCategory = "Tüm Kategoriler";

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() async {
    QuerySnapshot snapshot;
    if (selectedCategory == "Tüm Kategoriler") {
      snapshot = await _questionsCollection.get();
    } else {
      snapshot = await _questionsCollection
          .where('category', isEqualTo: selectedCategory)
          .get();
    }
    setState(() {
      questions = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soru Güncelle"),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
                _loadQuestions();
              });
            },
            items: ["Tüm Kategoriler", "C#", "Java", "Flutter"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(questions[index]['question']),
                  subtitle: Text(questions[index]['category']),
                  onTap: () {
                    _navigateToUpdateScreen(questions[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToUpdateScreen(QueryDocumentSnapshot question) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionEditScreen(question: question),
      ),
    );
  }
}

class QuestionEditScreen extends StatefulWidget {
  final QueryDocumentSnapshot question;

  QuestionEditScreen({required this.question});

  @override
  _QuestionEditScreenState createState() => _QuestionEditScreenState();
}

class _QuestionEditScreenState extends State<QuestionEditScreen> {
  TextEditingController _questionController = TextEditingController();
  TextEditingController _answer1Controller = TextEditingController();
  TextEditingController _answer2Controller = TextEditingController();
  TextEditingController _answer3Controller = TextEditingController();
  TextEditingController _answer4Controller = TextEditingController();
  int correctAnswer = 1;
  late String selectedCategory;
  late List<String> categories;
  bool isAnswerSelected = false;

  @override
  void initState() {
    super.initState();
    _questionController.text = widget.question['question'];
    _answer1Controller.text = widget.question['answer1'];
    _answer2Controller.text = widget.question['answer2'];
    _answer3Controller.text = widget.question['answer3'];
    _answer4Controller.text = widget.question['answer4'];
    correctAnswer = widget.question['correctAnswer'] ?? 1;

    categories = ["C#", "Java", "Flutter"];
    selectedCategory = widget.question['category'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soru Düzenleme"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Soru:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: _questionController,
                decoration: InputDecoration(
                  hintText: "Soruyu buraya girin",
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Kategori:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text(
                "Şıklar:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              for (int i = 1; i <= 4; i++)
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: i == 1
                            ? _answer1Controller
                            : i == 2
                                ? _answer2Controller
                                : i == 3
                                    ? _answer3Controller
                                    : _answer4Controller,
                        decoration: InputDecoration(
                          labelText: "Cevap $i",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Checkbox(
                      value: correctAnswer == i,
                      onChanged: (value) {
                        setState(() {
                          correctAnswer = value! ? i : 0;
                          isAnswerSelected = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (isAnswerSelected) {
                    _updateQuestion();
                  } else {
                    _showErrorDialog();
                  }
                },
                child: Text("Soruyu Güncelle"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateQuestion() {
    widget.question.reference.update({
      'question': _questionController.text,
      'category': selectedCategory,
      'answer1': _answer1Controller.text,
      'answer2': _answer2Controller.text,
      'answer3': _answer3Controller.text,
      'answer4': _answer4Controller.text,
      'correctAnswer': correctAnswer,
    }).then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      print("Hata oluştu: $error");
    });
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Hata"),
          content: Text("Lütfen doğru cevabı belirleyebilmek için bir şık seçiniz."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: QuestionUpdateScreen(),
  ));
}
