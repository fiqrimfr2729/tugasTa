import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smk_losarangg/api-services/api.dart';
import 'package:smk_losarangg/const.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';
import 'package:smk_losarangg/screen/edit_password.dart';
import 'package:smk_losarangg/screen/login.dart';

class Coment extends StatefulWidget {
  final String idPengumuman;

  const Coment({Key key, this.idPengumuman}) : super(key: key);
  @override
  _ComentState createState() => _ComentState();
}

class _ComentState extends State<Coment> {
  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    print(widget.idPengumuman);
    super.initState();
    Provider.of<ProviderBimbingan>(context, listen: false).getListKomentar(idPengumuman: widget.idPengumuman).then((value) => print(value.data)); //karena beda kelas maka diakses menggunakan widget

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Komentar"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Flexible(child: Consumer<ProviderBimbingan>(builder: (context, value, child){
                if(value.komentar==null){
                  return Center(child: CircularProgressIndicator(),);
                } else {
                  if(value.komentar.data.length==0) {
                    return Center(child: Text("Belum ada komentar"),);
                  } else {
                    return ListView.builder(
                      itemCount: value.komentar.data.length,
                      itemBuilder: (c,i){
                      return ListTile(title: Text("${value.komentar.data[i].komentator}"),
                      subtitle: Text("${value.komentar.data[i].isiKomentar}"),trailing: Text("${value.komentar.data[i].createdAt}"),);
                    });
                  }
                }
              })),
              Container(
                child: Row(
                  children: <Widget>[
                    // Button send image

                    // Edit text
                    Flexible(
                      child: Container(
                        child: TextField(
                          onChanged: (v) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var idUserAcount;
                            setState(() {
                              idUserAcount = prefs.get('id_user');
                            });
                            Firestore.instance
                                .collection('users')
                                .document(idUserAcount)
                                .updateData({
                              'id_user': idUserAcount,
                              'status': 'mengetik...',
                              'last_seen': DateTime.now(),
                            });
                          },
                          onSubmitted: (v) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var idUserAcount;
                            setState(() {
                              idUserAcount = prefs.get('id_user');
                            });
                            Firestore.instance
                                .collection('users')
                                .document(idUserAcount)
                                .updateData({
                              'id_user': idUserAcount,
                              'status': 'online',
                              'last_seen': DateTime.now(),
                            });
                          },
                          onEditingComplete: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var idUserAcount;
                            setState(() {
                              idUserAcount = prefs.get('id_user');
                            });
                            Firestore.instance
                                .collection('users')
                                .document(idUserAcount)
                                .updateData({
                              'id_user': idUserAcount,
                              'status': 'online',
                              'last_seen': DateTime.now(),
                            });
                          },
                          style: TextStyle(color: primaryColor, fontSize: 15.0),
                          controller: textEditingController,
                          maxLength: 1000,
                          maxLines: 10,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration.collapsed(
                            hintText: 'ketik pesan anda disini...',
                            hintStyle: TextStyle(color: greyColor),
                          ),
                          focusNode: focusNode,
                        ),
                      ),
                    ),

                    // Button send message
                    Material(
                      child: new Container(
                        margin: new EdgeInsets.symmetric(horizontal: 8.0),
                        child: new IconButton(
                          icon: new Icon(Icons.send),
                          onPressed: () {
                            Provider.of<ProviderBimbingan>(context, listen: false).addKomentar(idPengumuman: widget.idPengumuman, isiKomentar: textEditingController.text).then((value) { Provider.of<ProviderBimbingan>(context, listen: false).getListKomentar(idPengumuman: widget.idPengumuman).then((value) => print(value.data));
                            focusNode.unfocus();
                            textEditingController.text="";
                            
                            });
                          },
                          color: primaryColor,
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
                width: double.infinity,
                height: textEditingController.text.length > 50 ? 100 : 50,
                decoration: new BoxDecoration(
                    border: new Border(
                        top: new BorderSide(color: greyColor2, width: 0.5)),
                    color: Colors.white),
              )
            ],
          )
        ]),
      ),
    );
  }
}
