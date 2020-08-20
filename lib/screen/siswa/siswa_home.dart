import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';
import 'package:smk_losarangg/providers/p_users.dart';
import 'package:smk_losarangg/screen/pemberitahuan.dart';
import 'package:smk_losarangg/screen/siswa/siswa_absensi.dart';
import 'package:smk_losarangg/screen/siswa/siswa_mulaibimbingan.dart';
import 'package:smk_losarangg/screen/siswa/siswa_profil.dart';
import 'package:smk_losarangg/screen/siswa/v_chat_room.dart';
import 'package:smk_losarangg/screen/tentang.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:pull_to_refresh/pull_to_refresh.dart'; 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    Provider.of<ProviderBimbingan>(context, listen: false).loadingbimbingan =
        true;
    Provider.of<ProviderBimbingan>(context, listen: false)
        .getListBimbingan()
        .then((value) => _refreshController.refreshCompleted());
  }

  String _timeString;
  var nik;
  var idUser;
  var idUserSiswa;
  var idSekolah;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    if (this.mounted) {
      setState(() {
        _timeString = formattedDateTime;
      });
    }
  }

  getSeason() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idSekolah = pref.get("id_sekolah");
    });
    print(idSekolah);
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('kk:mm:ss').format(dateTime);
  }

  firestore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idUser = prefs.get('id_user');
    setState(() {
      idUserSiswa = prefs.get('id_user');
    });
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: idUser)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length == 0) {
      Firestore.instance.collection('users').document(idUser).setData({
        'status': "online",
        "id_user": idUser,
        'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
        'last_seen': DateTime.now(),
      });
    } else {
      Firestore.instance.collection('users').document(idUser).updateData({
        'id_user': idUser,
        'status': 'online',
        'last_seen': DateTime.now(),
      });
    }
  }

  @override
  void initState() {
    firebaseMessaging.getToken().then((value) =>
        Provider.of<ProviderUsers>(context, listen: false)
            .updateToken(token_firebase: value));
    firestore();
    WidgetsBinding.instance
        .addObserver(this); //instansiasi siklus hidup aktivity
    Provider.of<ProviderUsers>(context, listen: false).updateStatus(
      status: "online",
    );
    getSeason();
    Provider.of<ProviderUsers>(context, listen: false)
        .getGuruBK()
        .then((value) {
      setState(() {
        nik = value.data[0].nik.toString();
        idUser = value.data[0].idUser.toString();
        print(nik);
      });
    });
    timeago.setLocaleMessages('id', timeago.IdMessages());
    // TODO: implement initState
    Provider.of<ProviderBimbingan>(context, listen: false).loadingbimbingan =
        true;
    Provider.of<ProviderBimbingan>(context, listen: false).getListBimbingan();
    if (this.mounted) {
      Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    }
    super.initState();
  }

  static var today = new DateTime.now();
  var formatedTanggal = new DateFormat.yMMMd().format(today);

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("resumen");
      Firestore.instance.collection('users').document(idUserSiswa).updateData({
        'id_user': idUserSiswa,
        'status': 'online',
        'last_seen': DateTime.now(),
      });
    } else if (state == AppLifecycleState.inactive) {
      Firestore.instance.collection('users').document(idUserSiswa).updateData({
        'id_user': idUserSiswa,
        'status': 'online',
        'last_seen': DateTime.now(),
      });
      print("inactive");
    } else if (state == AppLifecycleState.detached) {
      Firestore.instance.collection('users').document(idUserSiswa).updateData({
        'id_user': idUserSiswa,
        'status': 'offline',
        'last_seen': DateTime.now(),
      });
      print("detached");
    } else if (state == AppLifecycleState.paused) {
      Firestore.instance.collection('users').document(idUserSiswa).updateData({
        'id_user': idUserSiswa,
        'status': 'offline',
        'last_seen': DateTime.now(),
      });
      print("paused");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color(0xFF527318),
            automaticallyImplyLeading: false,
            pinned: true,
            //biar tulisannya tetep ada pas discroll
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Pemberitahuan()));
                },
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profil()));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 20, bottom: 10, top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.asset(
                      'assets/user.jpg',
                      height: 15,
                      width: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
            floating: false,
            expandedHeight: 300.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                idSekolah == "1" ? 'BK-SMKN 1 Losarang' : 'BK-SMAN 1 Tukdana',
                style: TextStyle(color: Colors.white),
              ),
              background: Container(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: <Widget>[
                    idSekolah == "1"
                        ? Image.asset(
                            'assets/logo.png',
                            height: 80,
                          )
                        : Image.asset(
                            'assets/tukdana.png',
                            height: 80,
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      formatedTanggal.toString(),
                      style: GoogleFonts.abhayaLibre(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " ${_timeString}",
                      style: GoogleFonts.abhayaLibre(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: <Widget>[
                    // Container(
                    //   margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    //   padding: EdgeInsets.only(left: 20, right: 20),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       border: Border.all(color: Colors.grey)),
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //         border: InputBorder.none,
                    //         hintText: 'Cari di sini ...'),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Consumer<ProviderBimbingan>(
                      builder: (context, data, _) {
                        if (data.loadingbimbingan) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          if (data.modelBimbingan.totalData == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Text("Anda belum melakukan bimbingan."),
                            );
                          } else {
                            return Container(
                              height: 500,
                              width: double.infinity,
                              child: SmartRefresher(
                                enablePullUp: true,
                                header: WaterDropHeader(
                                  waterDropColor: Colors.amber,
                                ),
                                controller: _refreshController,
                                onRefresh: _onRefresh,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: data.modelBimbingan.data.map((e) {
                                      return Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 10, left: 15, right: 15),
                                          child: Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: InkWell(
                                              onTap: () {
                                                Provider.of<ProviderBimbingan>(
                                                        context,
                                                        listen: false)
                                                    .updateStatusBimbingan(
                                                        context: context,
                                                        isSiswa: true,
                                                        idBimbingan: e
                                                            .idBimbingan
                                                            .toString())
                                                    .then((value) {
                                                  Provider.of<ProviderBimbingan>(
                                                          context,
                                                          listen: false)
                                                      .getListBimbingan();
                                                });

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewChatRoom(
                                                              to: idUser,
                                                              idBimbigan: e
                                                                  .idBimbingan
                                                                  .toString(),
                                                              isiBimbingan: e
                                                                  .isiBim
                                                                  .toLowerCase(),
                                                              peerId: nik,
                                                              idUser: idUser,
                                                              isSiswa: true

                                                            )));
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10,
                                                            top: 10,
                                                            left: 10),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                      child: Image.asset(
                                                        'assets/user.jpg',
                                                        height: 50,
                                                        width: 50,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                '${e.subject}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              e.status == "0"
                                                                  ? Container(
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              20),
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              15,
                                                                          vertical:
                                                                              5),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .red,
                                                                          borderRadius:
                                                                              BorderRadius.circular(29)),
                                                                      child:
                                                                          Text(
                                                                        "New",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    )
                                                                  : Container()
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "${timeago.format(e.createdAt, locale: 'id', allowFromNow: true)}",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    Colors.grey,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "${e.isiBim}",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                    }).toList()),
                              ),
                            );
                          }
                        }
                      },
                    )
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: true,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        //backgroundColor: Color(0xFF28915E),
        backgroundColor: Color(0xFF527318),
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(
                Icons.supervisor_account,
                color: Colors.white,
              ),
              backgroundColor: Color(0xFFFEB72B),
              label: 'Bimbingan',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MulaiBimbingan()))),
          SpeedDialChild(
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
              backgroundColor: Colors.blue,
              label: 'Absensi',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Absensi()))),
          SpeedDialChild(
              child: Icon(
                Icons.info,
                color: Colors.white,
              ),
              backgroundColor: Colors.red,
              label: 'Tentang App',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Tentang()))),
        ],
      ),
    );
  }
}
