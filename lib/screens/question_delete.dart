import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionDeleteScreen extends StatefulWidget {
  @override
  _QuestionDeleteScreenState createState() => _QuestionDeleteScreenState();
}

class _QuestionDeleteScreenState extends State<QuestionDeleteScreen> {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference _questionsCollection =
      FirebaseFirestore.instance.collection('questions');

  List<QueryDocumentSnapshot> questions = [];

  List<bool> selectedQuestions = [];

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() async {
    final QuerySnapshot snapshot = await _questionsCollection.get();
    setState(() {
      questions = snapshot.docs;
      selectedQuestions = List.generate(questions.length, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soru Silme Paneli"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(questions[index]['question']),
                  subtitle: Text(questions[index]['category']),
                  trailing: Checkbox(
                    value: selectedQuestions[index],
                    onChanged: (value) {
                      setState(() {
                        selectedQuestions[index] = value!;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_hasSelectedQuestions()) {
                  _showDeleteConfirmationDialog();
                } else {
                  _showSelectionWarningDialog();
                }
              },
              child: Text("Soruyu Sil"),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Emin misiniz?"),
          content: Text("Seçili soruları silmek istediğinizden emin misiniz?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("Hayır"),
            ),
            TextButton(
              onPressed: () {
                _deleteSelectedQuestions();
                Navigator.pop(context, true);
              },
              child: Text("Evet"),
            ),
          ],
        );
      },
    );
  }

  void _showSelectionWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Uyarı"),
          content: Text("Lütfen soru silmek için bir soru seçiniz."),
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

  bool _hasSelectedQuestions() {
    return selectedQuestions.contains(true);
  }

  void _deleteSelectedQuestions() async {
    for (int i = questions.length - 1; i >= 0; i--) {
      if (selectedQuestions[i]) {
        await _questionsCollection.doc(questions[i].id).delete();
        setState(() {
          questions.removeAt(i);
          selectedQuestions.removeAt(i);
        });
      }
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: QuestionDeleteScreen(),
  ));
}
