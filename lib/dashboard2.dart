import 'package:flutter/material.dart';
import 'package:quiz_app_tutorial/login.dart';
import 'package:quiz_app_tutorial/screens/question_add.dart';
import 'package:quiz_app_tutorial/screens/question_delete.dart';
import 'package:quiz_app_tutorial/screens/question_list.dart';
import 'package:quiz_app_tutorial/screens/question_update.dart';


class Dashboard2 extends StatefulWidget {
  const Dashboard2({super.key});

  @override
  State<Dashboard2> createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  List imgData = [
    "assets/images/add.png",
    "assets/images/remove.png",
    "assets/images/refresh.png",
    "assets/images/clipboard.png",
  ];

  List titles = [
    "Soru Ekle",
    "Soru Sil",
    "Soru Güncelle",
    "Soruları Listele",
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
                color: Colors.indigo,
                width: width,
                child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(),
              height: height * 0.23,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.07,//height değeri laptopta 50 idi
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                          },
                          child: const Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/admin2.png'))),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Admin Paneli",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: height * 0.8,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 32, 26, 26),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                   ),
                //height: height,
                width: width,
                padding: EdgeInsets.only(bottom: 20, top: height * 0.07),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                     mainAxisSpacing: 25,
                  ),
                  
                shrinkWrap: true,
                
                physics: const NeverScrollableScrollPhysics(),
                itemCount: imgData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                      Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => QuestionAddScreen()),
                        );
                      }
                      else if (index == 1) {
                      Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => QuestionDeleteScreen()),
                        );
                      }
                      else if (index == 2) {
                      Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => QuestionUpdateScreen()),
                        );
                      }
                      else if (index == 3) {
                      Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => QuestionListScreen()),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 255, 17, 1),
                            spreadRadius: 1,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            imgData[index],
                          width: 100,
                          ),
                          Text(
                            titles[index],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            ),
                        ],
                      ),
                    ),
                  );
                } ,
                ),
              ),
            ),
          ],
                ),
              ),
        )
   );
  }
}
