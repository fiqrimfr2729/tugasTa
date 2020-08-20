import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';
import 'package:smk_losarangg/providers/p_users.dart';
import 'package:smk_losarangg/screen/guru/guru_absensi.dart';
import 'package:smk_losarangg/screen/guru/guru_master.dart';
import 'package:smk_losarangg/screen/guru/guru_profil.dart';
import 'package:smk_losarangg/screen/pemberitahuan.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:smk_losarangg/screen/siswa/v_chat_room.dart';
import 'package:smk_losarangg/screen/tentang.dart';

import 'package:timeago/timeago.dart' as timeago;

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> with WidgetsBindingObserver {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
   Provider.of<ProviderBimbingan>(context, listen: false).loadingbimbingan =
        true;
    Provider.of<ProviderBimbingan>(context, listen: false)
        .getListBimbinganGuru()
        .then((value) {
           // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
      if (value.totalData != 0) {
        value.data.forEach((element) {
          if (element.statusByGuru.toString() == "0") {
            setState(() {
              bimbinganBaru += 1;
            });
          }
        });
      }
    });
   
  }

  String _timeString;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  var idUser;
  var idSekolah;
  int bimbinganBaru = 0;
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
      print(idSekolah);
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('kk:mm:ss').format(dateTime);
  }

  firestore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idUser = prefs.get('id_user');
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
    WidgetsBinding.instance.addObserver(this);
    getSeason();
    timeago.setLocaleMessages('id', timeago.IdMessages());
    Provider.of<ProviderBimbingan>(context, listen: false).loadingbimbingan =
        true;
    Provider.of<ProviderBimbingan>(context, listen: false)
        .getListBimbinganGuru()
        .then((value) {
      if (value.totalData != 0) {
        value.data.forEach((element) {
          if (element.statusByGuru.toString() == "0") {
            setState(() {
              bimbinganBaru += 1;
            });
          }
        });
      }
    });
    // TODO: implement initState
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
      Provider.of<ProviderBimbingan>(context, listen: false)
          .getListBimbinganGuru()
          .then((value) {
        if (value.totalData != 0) {
          value.data.forEach((element) {
            if (element.statusByGuru.toString() == "0") {
              setState(() {
                bimbinganBaru += 1;
              });
            }
          });
        }
      });
      Firestore.instance.collection('users').document(idUser).updateData({
        'id_user': idUser,
        'status': 'online',
        'last_seen': DateTime.now(),
      });
    } else if (state == AppLifecycleState.inactive) {
      Firestore.instance.collection('users').document(idUser).updateData({
        'id_user': idUser,
        'status': 'online',
        'last_seen': DateTime.now(),
      });
      Provider.of<ProviderBimbingan>(context, listen: false)
          .getListBimbinganGuru()
          .then((value) {
        if (value.totalData != 0) {
          value.data.forEach((element) {
            if (element.statusByGuru.toString() == "0") {
              setState(() {
                bimbinganBaru += 1;
              });
            }
          });
        }
      });
      print("inactive");
    } else if (state == AppLifecycleState.detached) {
      Firestore.instance.collection('users').document(idUser).updateData({
        'id_user': idUser,
        'status': 'offline',
        'last_seen': DateTime.now(),
      });
      Provider.of<ProviderBimbingan>(context, listen: false)
          .getListBimbinganGuru()
          .then((value) {
        if (value.totalData != 0) {
          value.data.forEach((element) {
            if (element.statusByGuru.toString() == "0") {
              setState(() {
                bimbinganBaru += 1;
              });
            }
          });
        }
      });
      print("detached");
    } else if (state == AppLifecycleState.paused) {
      Firestore.instance.collection('users').document(idUser).updateData({
        'id_user': idUser,
        'status': 'offline',
        'last_seen': DateTime.now(),
      });
      print("paused");
      Provider.of<ProviderBimbingan>(context, listen: false)
          .getListBimbinganGuru()
          .then((value) {
        if (value.totalData != 0) {
          bimbinganBaru = 0;
          value.data.forEach((element) {
            if (element.statusByGuru.toString() == "0") {
              setState(() {
                bimbinganBaru += 1;
              });
            }
          });
        }
      });
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
                      MaterialPageRoute(builder: (context) => ProfilGuru()));
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
                      "${_timeString}",
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
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 38, left: 38, top: 45, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "${bimbinganBaru}",
                                style: TextStyle(
                                  color: Color(0xFF527318),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                'Bimbingan Baru',
                                style: TextStyle(
                                  color: Color(0xFF527318),
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.amber,
                            width: 0.2,
                            height: 22,
                          ),
                          Container(
                            color: Colors.amber,
                            width: 0.2,
                            height: 22,
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
                                if (data.modelBimbinganGuru.totalData == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 60),
                                    child: Text("Data Kosong"),
                                  );
                                } else {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${data.modelBimbinganGuru.totalData}',
                                        style: TextStyle(
                                          color: Color(0xFF527318),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                      Text(
                                        'Total Bimbingan',
                                        style: TextStyle(
                                          color: Color(0xFF527318),
                                        ),
                                      )
                                    ],
                                  );
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ),
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
                          if (data.modelBimbinganGuru.totalData == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Text("Data Kosong"),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:
                                        data.modelBimbinganGuru.data.map((e) {
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
                                                        isSiswa: false,
                                                        idBimbingan: e.idBimbingan
                                                            .toString())
                                                    .then((res) {
                                                  Provider.of<ProviderBimbingan>(
                                                          context,
                                                          listen: false)
                                                      .getListBimbinganGuru()
                                                      .then((value) {
                                                    if (value.totalData != 0) {
                                                      bimbinganBaru = 0;
                                                      value.data
                                                          .forEach((element) {
                                                        if (element.statusByGuru
                                                                .toString() ==
                                                            "0") {
                                                          setState(() {
                                                            bimbinganBaru += 1;
                                                          });
                                                        }
                                                      });
                                                    }
                                                  });
                                                });

                                                print(e.detailSiswa.idUser);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewChatRoom(
                                                              idBimbigan: e
                                                                  .idBimbingan
                                                                  .toString(),
                                                              isiBimbingan: e
                                                                  .isiBim
                                                                  .toLowerCase(),
                                                              peerId: e
                                                                  .detailSiswa.nis
                                                                  .toString(),
                                                              isSiswa: false,
                                                              idUser: e
                                                                  .detailSiswa
                                                                  .idUser,
                                                              to: e.detailSiswa
                                                                  .idUser,
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
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      '${e.detailSiswa.namaSiswa}',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10,
                                                                          vertical:
                                                                              3),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .amber,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                      child: Text(
                                                                        '${e.subject}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ]),
                                                              e.statusByGuru ==
                                                                      "0"
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
                                                                      child: Text(
                                                                        "Baru",
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
                Icons.data_usage,
                color: Colors.white,
              ),
              backgroundColor: Colors.red,
              label: 'Data Master',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DataMaster()))),
          // SpeedDialChild(
          //     child: Icon(
          //       Icons.history,
          //       color: Colors.white,
          //     ),
          //     backgroundColor: Colors.red,
          //     label: 'Riwayat',
          //     labelStyle: TextStyle(fontSize: 18.0),
          //     onTap: () => Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => Riwayat()))),
          SpeedDialChild(
              child: Icon(
                Icons.info,
                color: Colors.white,
              ),
              backgroundColor: Colors.amber,
              label: 'Tentang App',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Tentang()))),
        ],
      ),
    );
  }
}
