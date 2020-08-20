import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tentang extends StatefulWidget {
  Tentang({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Tentang createState() => _Tentang();
}

class _Tentang extends State<Tentang> with SingleTickerProviderStateMixin {
  TabController controller;
  var idSekolah;

  getSeason() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idSekolah = pref.get("id_sekolah");    
      print(idSekolah);
      });
  }
  @override
  void initState() {
    super.initState();
    getSeason();
    controller = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
      
       children: <Widget>[
         Center(
           child: Padding(
             padding: const EdgeInsets.only(top: 250),
             child: idSekolah == "1"?
             Image.asset('assets/logo.png',) : Image.asset('assets/tukdana.png',),
             
           ),
         ),
         Padding(
           padding: const EdgeInsets.only(top: 350, left: 80),
           child: Text("Tentang Aplikasi", style: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
           
         ),
        //  SizedBox.expand(
        //    child: Image.asset("assets/logo.png", height: 450, width: 450, fit: BoxFit.cover),
        //  ),
        DraggableScrollableSheet(
          minChildSize: 0.1,
          initialChildSize: 0.22,
          builder: (context, scrollControler){
            return SingleChildScrollView(
              controller: scrollControler,
              child: Container(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 32, right: 32, top: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipOval(
                              child: 
                              idSekolah == "1"?
                              Image.asset('assets/logo.png', fit: BoxFit.cover) : Image.asset('assets/tukdana.png', fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(width: 16,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                               idSekolah == "1"?
                                Text("Aplikasi Bimbingan dan Konseling SMK Negeri 1 Losarang", style: TextStyle(color: Colors.grey[800],
                                fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center) :  Text("Aplikasi Bimbingan dan Konseling SMA Negeri 1 Tukdana", style: TextStyle(color: Colors.grey[800],
                                fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                              ],
                            ),
                            
                          ),
                          
                        ],
                      ),
                      
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                      child: Column(
                        children: <Widget>[
                          Text("1. Tentang Aplikasi",
                          style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.justify)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 25, right: 25),
                      child: Column(
                        children: <Widget>[
                          idSekolah == "1"?
                          Text("     Aplikasi bimbingan dan konseling ini merupakan aplikasi yang digunakan untuk mempermudah komunikasi antara siswa dengan guru bk. Siswa dapat melakukan bimbingan terkait masalah yang sedang dihadapinya kepada guru bk tanpa harus datang secara langsung ke ruangan bk. Selain itu, melalui aplikasi ini proses bimbingan menjadi lebih mudah dan efisien karena dapat dilakukan dimanapun dan kapanpun.",
                          style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 15, ), textAlign: TextAlign.justify) : Text("     Aplikasi bimbingan dan konseling ini merupakan aplikasi yang digunakan untuk mempermudah komunikasi antara siswa dengan guru bk. Siswa dapat melakukan bimbingan terkait masalah yang sedang dihadapinya kepada guru bk tanpa harus datang secara langsung ke ruangan bk. Selain itu, melalui aplikasi ini proses bimbingan menjadi lebih mudah dan efisien karena dapat dilakukan dimanapun dan kapanpun.",
                          style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 15, ), textAlign: TextAlign.justify)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 25, right: 25),
                      child: Column(
                        children: <Widget>[
                          Text("     Bimbingan yang disampaikan siswapun hanya dapat diketahui oleh guru bk dan siswa itu sendiri, sehingga masalah yang sedang dihadapi siswa dapat terjaga dengan baik. Siswa dan guru bk dapat melakukan live chating dengan menggunakan aplikasi ini, sehingga akan lebih mudah untuk mendapatkan solusi dari masalah tersebut.",
                          style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 15, ), textAlign: TextAlign.justify)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                      child: Column(
                        children: <Widget>[
                          Text("2. Teknologi yang Digunakan",
                          style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.justify)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 25, right: 25),
                      child: Column(
                        children: <Widget>[
                          Text("     Aplikasi ini dibuat dalam versi android untuk memudahkan pengguna dalam mengoprasikannya.",
                          style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 15, ), textAlign: TextAlign.justify)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
       ],
      ),
      
    );
  }
}
