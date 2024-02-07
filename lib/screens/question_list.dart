import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionListScreen extends StatefulWidget {
  @override
  _QuestionListScreenState createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
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
        title: Text("Soruları Listele"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: QuestionListScreen(),
  ));
}
