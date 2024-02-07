import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YazılımTest Uygulaması',
      home: AboutUsScreen(),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hakkımızda'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Merhaba! Uygulamamda yazılım dünyasına giriş yapan veya bilgisini test etmek isteyen yazılımcılar için tasarlanmış bir test çözme uygulaması sunmaktayım.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Misyonumuz',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'YazılımTest\'in temel misyonu, yazılım alanına ilgi duyan bireylere yönelik basit düzeyde testler sunmak ve onların bilgi düzeyini ölçerek kendilerini geliştirmelerine yardımcı olmaktır. Yazılım dünyasına adım atan herkesin bilgi seviyesini değerlendirme ve artırma amacını taşımaktadır.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Vizyonumuz',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'İlerleyen zamanlarda, YazılımTest\'i daha ayrıntılı, kapsamlı ve donanımlı bir uygulamaya dönüştürmeyi hedeflemekteyim. Kullanıcılarımıza daha fazla içerik, interaktif özellikler ve öğrenme kaynakları sunarak, yazılım bilgi ve becerilerini daha etkili bir şekilde geliştirmelerine katkıda bulunmayı amaçlıyorum.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Ekip',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'YazılımTest, şu an için tek bir geliştirici olan Muammer Kesmez tarafından tasarlanmıştır. Kendi deneyimlerim ve tutkumla bu uygulamayı sizlere sunmaktan mutluluk duyuyorum.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'İletişim',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Eğer herhangi bir sorunuz, öneriniz veya geri bildiriminiz varsa, lütfen bana muammerkesmezz@gmail.com adresinden ulaşın. Sizinle iletişim kurmak benim için önemlidir.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
