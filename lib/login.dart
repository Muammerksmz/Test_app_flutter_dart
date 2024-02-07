import 'package:flutter/material.dart';
import 'package:quiz_app_tutorial/admin.dart';
import 'package:quiz_app_tutorial/dashboard.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Column(
                  children: [
                    SizedBox(
                      //width: width,
                      height: height * 0.17,
                      child: const Text(
                        "YazılımTest",
                        style:
                            TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text("Hoşgeldiniz",
                      style:
                            TextStyle(fontSize: 20),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    
                    
                    const SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()),
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Biraz Test Çözelim",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
                
                const SizedBox(height: 60),

                TextButton(
                    onPressed: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPage()),
                          );
                    }, child: const Text("Admin Girişi",
                    style: TextStyle(fontSize: 20),
                    )
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
