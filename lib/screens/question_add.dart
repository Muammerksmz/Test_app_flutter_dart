import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionAddScreen extends StatefulWidget {
  @override
  _QuestionAddScreenState createState() => _QuestionAddScreenState();
}

class _QuestionAddScreenState extends State<QuestionAddScreen> {

  TextEditingController questionController = TextEditingController();
  TextEditingController answerController1 = TextEditingController();
  TextEditingController answerController2 = TextEditingController();
  TextEditingController answerController3 = TextEditingController();
  TextEditingController answerController4 = TextEditingController();

  Set<String> categories = {"C#", "Java", "Flutter"};
  String selectedCategory = "C#";

  int correctAnswer = 1;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference _questionsCollection =
      FirebaseFirestore.instance.collection('questions');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Soru Ekleme Paneli"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Lütfen soruyu yazınız",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              TextField(
                controller: questionController,
                decoration: InputDecoration(
                  labelText: "Soru",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: height * 0.01),
              for (int i = 1; i <= 4; i++)
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: i == 1
                            ? answerController1
                            : i == 2
                                ? answerController2
                                : i == 3
                                    ? answerController3
                                    : answerController4,
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
                        });
                      },
                    ),
                  ],
                ),
              SizedBox(height: height * 0.04),
              Text(
                "Lütfen kategori seçiniz",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(
                height: height * 0.08,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: categories.toList().map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_validateQuestion()) {
              _addQuestionToFirebase();
            }
          },
          child: Text("Soru Ekle"),
        ),
      ),
    );
  }

  bool _validateQuestion() {
    if (questionController.text.isEmpty ||
        answerController1.text.isEmpty ||
        answerController2.text.isEmpty ||
        answerController3.text.isEmpty ||
        answerController4.text.isEmpty ||
        correctAnswer == 0 ||
        selectedCategory.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hata"),
            content: Text("Lütfen tüm alanları doldurun ve doğru cevabı seçin."),
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
      return false;
    }
    return true;
  }

  void _addQuestionToFirebase() async {
    await _questionsCollection.add({
      'question': questionController.text,
      'answer1': answerController1.text,
      'answer2': answerController2.text,
      'answer3': answerController3.text,
      'answer4': answerController4.text,
      'correctAnswer': correctAnswer,
      'category': selectedCategory,
    });

    questionController.clear();
    answerController1.clear();
    answerController2.clear();
    answerController3.clear();
    answerController4.clear();

    setState(() {
      correctAnswer = 1;
      selectedCategory = "C#";
    });

    print("Soru Eklendi ve Firebase'e Kaydedildi");

    Navigator.pop(context);
  }
}

void main() {
  runApp(MaterialApp(
    home: QuestionAddScreen(),
  ));
}
