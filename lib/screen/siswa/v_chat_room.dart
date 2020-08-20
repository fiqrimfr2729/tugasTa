import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smk_losarangg/fullPhoto.dart';
import 'package:smk_losarangg/models/m_guru_bp.dart';
import 'package:smk_losarangg/models/m_list_chat.dart';
import 'package:smk_losarangg/models/message_model.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';
import 'dart:math' as math;
import 'package:smk_losarangg/const.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:smk_losarangg/providers/p_users.dart';

class ViewChatRoom extends StatefulWidget {
  final String peerId;

  final String idBimbigan;
  final String isiBimbingan;
  final String to;
  final bool isSiswa;
  final idUser;

  ViewChatRoom(
      {Key key,
      @required this.peerId,
      
      this.idBimbigan,
      this.isiBimbingan,
      this.isSiswa,
      this.idUser, this.to})
      : super(key: key);

  @override
  _ViewChatRoomState createState() => _ViewChatRoomState();
}

class _ViewChatRoomState extends State<ViewChatRoom> {
  var nama;

  getSession() async {
    if (widget.isSiswa) {
      Provider.of<ProviderUsers>(context, listen: false)
          .getGuruBK()
          .then((value) {
        setState(() {
          nama = value.data[0].namaGuru;
        });
      });
    } else {
      Provider.of<ProviderUsers>(context, listen: false)
          .getStatusSiswa(idUser: widget.idUser)
          .then((value) {
        print(value);
        setState(() {
          nama = value.data[0].namaSiswa;
        });
      });
    }
  }

  @override
  void initState() {
    print("siswa " + widget.idUser);
    getSession();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 0, left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset(
                        'assets/user.jpg',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              nama==null ? "Pengguna BimKons" : "$nama",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance
                                  .collection('users')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              themeColor)));
                                } else {
                                  var status;
                                  Timestamp last_seen;
                                  snapshot.data.documents.forEach((element) {
                                    if (element['id_user'] == widget.idUser) {
                                      status = element['status'];
                                      last_seen = element['last_seen'];
                                    }
                                  });

                                  return status.toString() == "offline"
                                      ? Text(
                                          "${timeago.format(last_seen.toDate(), locale: 'id', allowFromNow: true)}",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 12),
                                        )
                                      : Text("$status",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 12));
                                }
                              },
                            ),
//                        data.modelGuruBk.data[0].status.toString()=="offline" ?
//                        Text("${timeago.format(data.modelGuruBk.data[0].updatedAt, locale: 'id', allowFromNow: true)}",style: TextStyle(color: Colors.white))
//                            :Text("${data.modelGuruBk.data[0].status}",style: TextStyle(color: Colors.white)),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            
         
          ],
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Center(child: Text("${widget.isiBimbingan}",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),))),
           Positioned(
             top: 30,
             left: 0,
             right: 0,
             bottom: 10,
                        child: ChatScreen(
              peerId: widget.peerId,
              idBimbingan: widget.idBimbigan,
              isiBimbigan: widget.isiBimbingan,
              
              isSiswa: widget.isSiswa,
              idUser: widget.idUser,
              to: widget.to,
          ),
           ),
        ],
      ),
    );
  }
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState(
      {Key key,
      @required this.peerId,
     
      @required this.idBimbingan,
      @required this.to,
      @required this.isiBimbingan,
      @required this.isSiswa,
      @required this.idUser});

  String peerId;
  
  String id;
  String to;
  String idUser;
  String idBimbingan;
  String isiBimbingan;
  final bool isSiswa;

  var listMessage;
  String groupChatId;
  SharedPreferences prefs;

  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

//  var idUserAcount;
//  getSession()async{
//    print(widget.isSiswa);
//    if(widget.isSiswa){
//      Provider.of<ProviderUsers>(context,listen: false).getGuruBK().then((value) {
//        setState(() {
//          idUserAcount=value.data[0].idUser;
//        });
//      });
//    }else{
//      Provider.of<ProviderUsers>(context,listen: false).getStatusSiswa(idUser: widget.idUser).then((value) {
//        print(value);
//        setState(() {
//          idUserAcount=value.data[0].idUser;
//        });
//      });
//
//    }
//  }
var nama;
 getSession() async {
   SharedPreferences pref = await SharedPreferences.getInstance();
   
    if (widget.isSiswa) {
      setState(() {
     nama = pref.get("nama_siswa");
   });
    } else {
      setState(() {
     nama = pref.get("nama_guru");
   });
    }
  }


  @override
  void initState() {
    super.initState();
    getSession();
    focusNode.addListener(onFocusChange);

    groupChatId = idBimbingan;

    isLoading = false;
    isShowSticker = false;
    imageUrl = '';

    readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('nis') ?? '';

    print(peerId);
//    print("ini id "+id.hashCode.toString());
//    print("ini peeID "+peerId.hashCode.toString());
    groupChatId = idBimbingan;
//    if (id.hashCode <= peerId.hashCode) {
//      print("true");
//      groupChatId = '$id-$peerId';
//    } else {
//      print("false");
//      groupChatId = '$peerId-$id';
//    }

//    Firestore.instance.collection('users').document(id).updateData({'chattingWith': peerId});

    setState(() {});
  }

  Future getImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadFile();
    }
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 1);
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

  void onSendMessage(String content, int type) async{
    // type: 0 = text, 1 = image, 2 = sticker
   
    if (content.trim() != '') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var idUserAcount;
      setState(() {
        idUserAcount=prefs.get('id_user');
      });
      Firestore.instance.collection('users').document(idUserAcount).updateData(
          {'id_user': idUserAcount, 'status': 'online', 'last_seen': DateTime.now(),});
      textEditingController.clear();

      var documentReference = Firestore.instance
          .collection('messages')
          .document(groupChatId)
          .collection(groupChatId)
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': id,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
          Provider.of<ProviderUsers>(context, listen: false).sendNotif(to: to, title: nama, message: content);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document['idFrom'] == id) {
      // Right (my message)
      return Row(
        children: <Widget>[
          document['type'] == 0
              // Text
              ? Container(
                  child: Text(
                    document['content'],
                    style: TextStyle(color: primaryColor),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: greyColor2,
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(
                      bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                      right: 10.0),
                )
              : document['type'] == 1
                  // Image
                  ? Container(
                      child: FlatButton(
                        child: Material(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(themeColor),
                              ),
                              width: 200.0,
                              height: 200.0,
                              padding: EdgeInsets.all(70.0),
                              decoration: BoxDecoration(
                                color: greyColor2,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Material(
                              child: Image.asset(
                                'images/img_not_available.jpeg',
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                            ),
                            imageUrl: document['content'],
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FullPhoto(url: document['content'])));
                        },
                        padding: EdgeInsets.all(0),
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    )
                  // Sticker
                  : Container(
                      child: new Image.asset(
                        'assets/stikers/${document['content']}.gif',
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                    ? Container()
                    : Container(width: 35.0),
                document['type'] == 0
                    ? Container(
                        child: Text(
                          document['content'],
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200.0,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(left: 10.0),
                      )
                    : document['type'] == 1
                        ? Container(
                            child: FlatButton(
                              child: Material(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          themeColor),
                                    ),
                                    width: 200.0,
                                    height: 200.0,
                                    padding: EdgeInsets.all(70.0),
                                    decoration: BoxDecoration(
                                      color: greyColor2,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Material(
                                    child: Image.asset(
                                      'images/img_not_available.jpeg',
                                      width: 200.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  imageUrl: document['content'],
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                clipBehavior: Clip.hardEdge,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullPhoto(
                                            url: document['content'])));
                              },
                              padding: EdgeInsets.all(0),
                            ),
                            margin: EdgeInsets.only(left: 10.0),
                          )
                        : Container(
                            child: new Image.asset(
                              'assets/stikers/${document['content']}.gif',
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                            margin: EdgeInsets.only(
                                bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                                right: 10.0),
                          ),
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document['timestamp']))),
                      style: TextStyle(
                          color: greyColor,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() async{
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
//      Firestore.instance.collection('users').document(id).updateData({'chattingWith': null});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var idUserAcount;
      setState(() {
        idUserAcount=prefs.get('id_user');
      });
      Firestore.instance.collection('users').document(idUserAcount).updateData(
          {'id_user': idUserAcount, 'status': 'online', 'last_seen': DateTime.now(),});
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),

              // Sticker
              (isShowSticker ? buildSticker() : Container()),

              // Input content
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildSticker() {
    
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => onSendMessage('mimi1', 2),
                child: new Image.asset(
                  'assets/stikers/mimi1.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi2', 2),
                child: new Image.asset(
                  'assets/stikers/mimi2.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi3', 2),
                child: new Image.asset(
                  'assets/stikers/mimi3.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => onSendMessage('mimi4', 2),
                child: new Image.asset(
                  'assets/stikers/mimi4.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi5', 2),
                child: new Image.asset(
                  'assets/stikers/mimi5.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi6', 2),
                child: new Image.asset(
                  'assets/stikers/mimi6.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => onSendMessage('mimi7', 2),
                child: new Image.asset(
                  'assets/stikers/mimi7.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi8', 2),
                child: new Image.asset(
                  'assets/stikers/mimi8.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi9', 2),
                child: new Image.asset(
                  'assets/stikers/mimi9.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: greyColor2, width: 0.5)),
          color: Colors.white),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : Container(),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.image),
                onPressed: getImage,
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          // Material(
          //   child: new Container(
          //     margin: new EdgeInsets.symmetric(horizontal: 1.0),
          //     child: new IconButton(
          //       icon: new Icon(Icons.face),
          //       onPressed: getSticker,
          //       color: primaryColor,
          //     ),
          //   ),
          //   color: Colors.white,
          // ),

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
                keyboardType:TextInputType.multiline,
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
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: textEditingController.text.length >50 ? 100 : 50,
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: greyColor2, width: 0.5)),
          color: Colors.white),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId == ''
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
          : StreamBuilder(
              stream: Firestore.instance
                  .collection('messages')
                  .document(groupChatId)
                  .collection(groupChatId)
                  .orderBy('timestamp', descending: true)
                  .limit(20)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(themeColor)));
                } else {
                  listMessage = snapshot.data.documents;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildItem(index, snapshot.data.documents[index]),
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String peerId;

  final String idBimbingan;
  final String isiBimbigan;
  final bool isSiswa;
  final String idUser;
  final String to;

  ChatScreen(
      {Key key,
      @required this.peerId,
      this.idBimbingan,
      this.isiBimbigan,
      this.isSiswa,
      this.idUser, this.to})
      : super(key: key);

  @override
  State createState() => new ChatScreenState(
        peerId: peerId,
       
        isiBimbingan: isiBimbigan,
        idBimbingan: idBimbingan,
        isSiswa: isSiswa,
        to: to,
        idUser: idUser,
      );
}
