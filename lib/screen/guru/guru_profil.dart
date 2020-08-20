import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smk_losarangg/screen/edit_password.dart';
import 'package:smk_losarangg/screen/login.dart';

class ProfilGuru extends StatefulWidget {
  @override
  _ProfilGuruState createState() => _ProfilGuruState();
}

class _ProfilGuruState extends State<ProfilGuru> {
  String nama;
  String nip;
  String jabatan;
  String email;
  String alamat;

  getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nama = pref.get("nama_guru");
      nip = pref.get("nik");
      jabatan = pref.get("nama_jabatan");
      email = pref.get("email_guru");
      alamat = pref.get("alamat_guru");
    });
  }

  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("nis");
    pref.remove("nik");
    var idUser = pref.get("id_user");
    Firestore.instance.collection('users').document(idUser).updateData({
      'id_user': idUser,
      'status': 'offline',
      'last_seen': DateTime.now(),
    });
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // appBar: AppBar(
      //      automaticallyImplyLeading: false,
      //      backgroundColor: Colors.white,
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 30),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/user.jpg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 38.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "$nama",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Color(0xFF527318),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.school,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "$jabatan",
                                style: TextStyle(
                                  color: Colors.amber,
                                  wordSpacing: 2,
                                  letterSpacing: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       right: 38, left: 38, top: 45, bottom: 12),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           Text(
            //             '24',
            //             style: TextStyle(
            //               color: Color(0xFF527318),
            //               fontWeight: FontWeight.bold,
            //               fontSize: 25,
            //             ),
            //           ),
            //           Text(
            //             'Bimbingan Baru',
            //             style: TextStyle(
            //               color: Color(0xFF527318),
            //             ),
            //           )
            //         ],
            //       ),
            //       Container(
            //         color: Colors.amber,
            //         width: 0.2,
            //         height: 22,
            //       ),
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           Text(
            //             '17',
            //             style: TextStyle(
            //               color: Color(0xFF527318),
            //               fontWeight: FontWeight.bold,
            //               fontSize: 25,
            //             ),
            //           ),
            //           Text(
            //             'Bimbingan Selesai',
            //             style: TextStyle(
            //               color: Color(0xFF527318),
            //             ),
            //           )
            //         ],
            //       ),
            //       Container(
            //         color: Colors.amber,
            //         width: 0.2,
            //         height: 22,
            //       ),
            //       InkWell(
            //         onTap: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => EditPasswordGuru()));
            //         },
            //         child: Container(
            //           padding: EdgeInsets.only(
            //               left: 18, right: 18, top: 8, bottom: 8),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.all(Radius.circular(33)),
            //             gradient: LinearGradient(
            //                 colors: [Colors.amber, Color(0xFF527318)],
            //                 begin: Alignment.bottomRight,
            //                 end: Alignment.centerLeft),
            //           ),
            //           child: Text(
            //             'Edit\nPassword',
            //             style: TextStyle(
            //                 color: Colors.white, fontWeight: FontWeight.bold),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                width: double.infinity,
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(34), bottom: Radius.circular(34))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 33, right: 25),
                      child: Text(
                        'Informasi Akun',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.amber),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 25),
                      child: Container(
                        height: 2,
                        width: 400,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Material(
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.school,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Nomor Induk Pegawai",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "$nip",
                                style:
                                    TextStyle(letterSpacing: 1.2, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Material(
                          color: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.room_service,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Jabatan",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "$jabatan",
                                style:
                                    TextStyle(letterSpacing: 1.2, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Material(
                          color: Colors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "$email",
                                style:
                                    TextStyle(letterSpacing: 1.2, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Material(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.location_city,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Alamat",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "$alamat",
                                style:
                                    TextStyle(letterSpacing: 1.2, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Material(
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditPassword()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Ganti Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Ganti Password yang sudah ada",
                                  style: TextStyle(
                                      letterSpacing: 1.2, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Material(
                          color: Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.keyboard_backspace,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => logout(),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Keluarkan akun dari aplikasi",
                                  style: TextStyle(
                                      letterSpacing: 1.2, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  "Politeknik Negeri Indramayu",
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
