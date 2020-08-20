import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smk_losarangg/fullPhoto.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';
import 'package:smk_losarangg/api-services/api.dart';
import 'package:smk_losarangg/screen/add_informasi.dart';
import 'package:smk_losarangg/screen/komentar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Pemberitahuan extends StatefulWidget {
  Pemberitahuan({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Pemberitahuan createState() => _Pemberitahuan();
}

class _Pemberitahuan extends State<Pemberitahuan> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    Provider.of<ProviderBimbingan>(context, listen: false)
        .getListPengumuman()
        .then((value) => _refreshController.refreshCompleted());
  }

  ReceivePort _port = ReceivePort();
  var role;
  @override
  void initState() {
    Provider.of<ProviderBimbingan>(context, listen: false).getListPengumuman();
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
    getSeason();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {}

  getSeason() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      role = pref.get('role');
      print(role);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: role == "guru"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TambahInformasi()));
              },
              child: Icon(Icons.add),
            )
          : null,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color(0xFF527318),
            automaticallyImplyLeading: false,
            pinned: true, //biar tulisannya tetep ada pas discroll
            actions: <Widget>[],
            floating: false,
            expandedHeight: 100.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Informasi',
                style: TextStyle(color: Colors.white),
              ),
              background: Container(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: <Widget>[
                    // Image.asset(
                    //   'assets/logo.png',
                    //   height: 80,
                    // ),
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
                    SizedBox(
                      height: 20,
                    ),
                    Consumer<ProviderBimbingan>(
                      builder: (context, data, _) {
                        if (data.modelListPengumuman == null) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.9,
                            width: double.infinity,
                            child: SmartRefresher(
                              enablePullUp: true,
                              header: WaterDropHeader(
                                waterDropColor: Colors.amber,
                              ),
                              controller: _refreshController,
                              onRefresh: _onRefresh,
                              child: SingleChildScrollView(
                                                              child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: data.modelListPengumuman.data
                                        .map((e) => Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 10, left: 15, right: 15),
                                            child: Card(
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100.0),
                                                              child: Image.asset(
                                                                'assets/user.jpg',
                                                                height: 35,
                                                                width: 35,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Flexible(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                Text(
                                                                  "${e.detailUser.namaGuru}",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                Text(
                                                                  "${e.tglBuat}",
                                                                  style: TextStyle(
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      e.foto.isEmpty
                                                          ? Container()
                                                          : e.foto
                                                                          .split(
                                                                              ".")
                                                                          .last ==
                                                                      "jpg" ||
                                                                  e.foto
                                                                          .split(
                                                                              ".")
                                                                          .last ==
                                                                      "jpeg" ||
                                                                  e.foto
                                                                          .split(
                                                                              ".")
                                                                          .last ==
                                                                      "png"
                                                              ? InkWell(
                                                                  onTap: () =>
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                FullPhoto(
                                                                              url:
                                                                                  "${ApiServer.foto}/${e.foto}",
                                                                            ),
                                                                          )),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        "${ApiServer.foto}/${e.foto}",
                                                                    placeholder: (c,
                                                                            i) =>
                                                                        CircularProgressIndicator(),
                                                                    height: 250,
                                                                    width: double
                                                                        .infinity,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                )
                                                              : InkWell(
                                                                  onTap: () =>
                                                                      downloader(
                                                                          url:
                                                                              "${ApiServer.foto}/${e.foto}"),
                                                                  child: Text(e
                                                                      .foto
                                                                      .toString()),
                                                                ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      SelectableText(
                                                        "${e.isiPengumuman}",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Coment(
                                                                            idPengumuman:
                                                                                e.idPengumuman,
                                                                          )));
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.comment,
                                                              color: Colors.black,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text("Komentar")
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ))))
                                        .toList()),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloader({String url}) async {
    var status = await Permission.storage.request();

    var path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    print(path);

    // var targetPath = appDocDir.path;

    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: path,
      requiresStorageNotLow: true,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }
}
