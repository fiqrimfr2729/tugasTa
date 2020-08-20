import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smk_losarangg/screen/guru/guru_home.dart';
import 'package:smk_losarangg/screen/login.dart';
import 'package:smk_losarangg/screen/siswa/siswa_home.dart';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();


  void firebaseCloudMessaging_Listeners() {
    firebaseMessaging.getToken().then((token) {
      print(token);
    });
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print(message);
        print(message['notification']);
        String title=message['notification']['title'];
        String body=message['notification']['body'];
       
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        String title=message['notification']['title'];
        String body=message['notification']['body'];
      },
      onLaunch: (Map<String, dynamic> message) async {
        String title=message['notification']['title'];
        String body=message['notification']['body'];
        print('on launch $message');
      },
    );
  }
  
  cekSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // print(pref.get("nik"));
    if(pref.get("nis")!= null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
    }
    else {
      if(pref.get("nik")!= null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PageHome()));
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseCloudMessaging_Listeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: 100.0),
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "SELAMAT DATANG",
            body: "di Aplikasi\nBimbingan dan Konseling",
            decoration: PageDecoration(
              bodyTextStyle: GoogleFonts.sourceCodePro(
                textStyle: TextStyle(color: Color(0xFFFEB72B), letterSpacing: .5, fontSize: 25.0),
              ),
              titleTextStyle: GoogleFonts.spicyRice(
                textStyle: TextStyle(
                    color: Color(0xFFFEB72B), letterSpacing: .5, fontSize: 50.0),
              ),
            ),
            image: Center(
              child: Image(
                image: AssetImage(
                  'assets/welcome.png',
                ),
                height: 300.0,
                width: 300.0,
              ),
            ),
          ),
          PageViewModel(
            title: "Kemudahan dalam Berkonsultasi",
            body:
                "Konsultasi dapat dilakukan di mana saja dan kapan saja tanpa memiliki batas waktu",
                decoration: PageDecoration(
              bodyTextStyle: GoogleFonts.indieFlower(
                textStyle: TextStyle(color: Color(0xFF899857), letterSpacing: .5, fontSize: 25.0),
              ),
              titleTextStyle: GoogleFonts.pacifico(
                textStyle: TextStyle(
                    color: Color(0xFF527318), letterSpacing: .5, fontSize: 40.0),
              ),
            ),
            image: Center(
              child: Image(
                image: AssetImage(
                  'assets/mudah.png',
                ),
                height: 350.0,
                width: 350.0,
              ),
            ),
          ),
          PageViewModel(
            title: "Gratis Konseling",
            body:
                "Guru BK di sekolah anda terbuka untuk melayani setiap siswa yang ingin berkonsultasi",
                decoration: PageDecoration(
              bodyTextStyle: GoogleFonts.indieFlower(
                textStyle: TextStyle(color: Color(0xFF899857), letterSpacing: .5, fontSize: 25.0),
              ),
              titleTextStyle: GoogleFonts.pacifico(
                textStyle: TextStyle(
                    color: Color(0xFF527318), letterSpacing: .5, fontSize: 40.0),
              ),
            ),
            image: Center(
              child: Image(
                image: AssetImage(
                  'assets/gratis.png',
                ),
                height: 350.0,
                width: 350.0,
              ),
            ),
          ),
          PageViewModel(
            title: "Ceritakan dan Temukan Solusinya",
            body: "Jika anda memiliki masalah, sebaiknya segera lakukan bimbingan. Ceritakan semuanya agar perasaan anda menjadi lebih baik",
          decoration: PageDecoration(
              bodyTextStyle: GoogleFonts.indieFlower(
                textStyle: TextStyle(color: Color(0xFF899857), letterSpacing: .5, fontSize: 25.0),
              ),
              titleTextStyle: GoogleFonts.pacifico(
                textStyle: TextStyle(
                    color: Color(0xFF527318), letterSpacing: .5, fontSize: 40.0),
              ),
            ),
            image: Center(
              child: Image(
                image: AssetImage(
                  'assets/2.png',
                ),
                height: 350.0,
                width: 350.0,
              ),
            ),
          )
        ],
        onDone: () {
          cekSession();
        },
        onSkip: () {
          cekSession();
        },
        showSkipButton: true,
        skip: const Text(
          'Lewati',
          style: TextStyle(color: Color(0xFF527318)),
        ),
        // next: const Text(
        //   '>',
        //   style: TextStyle(color: Color(0xFFFEB72B), fontSize: 30.0),
        // ),
        done:
            const Text("Mulai", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF527318)), ),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Color(0xFF527318),
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    ));
  }
}
