import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smk_losarangg/models/m_guru_bp.dart';
import 'package:smk_losarangg/models/m_list_chat.dart';
import 'package:smk_losarangg/models/m_status_siswa.dart';
import 'package:smk_losarangg/models/message_model.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';
import 'dart:math' as math;
import 'package:timeago/timeago.dart' as timeago;

import 'package:smk_losarangg/providers/p_users.dart';

class ViewChatRoomGuru extends StatefulWidget {
  final String  isiBimbingan;
  final String idBimbigan;
  final String idUser;
  final String nis;

  const ViewChatRoomGuru({Key key, this.isiBimbingan, this.idBimbigan, this.idUser, this.nis}) : super(key: key);
  @override
  _ViewChatRoomGuruState createState() => _ViewChatRoomGuruState();
}

class _ViewChatRoomGuruState extends State<ViewChatRoomGuru> {
  TextEditingController _controller=TextEditingController();
  String nik;

  getSession()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      nik=prefs.get("nik");
    });

    print("id "+widget.idUser);
  }
  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 80.0,
      )
          : EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery
          .of(context)
          .size
          .width * 0.75,
      decoration: BoxDecoration(
        color: Colors.grey[100 ],
        borderRadius: isMe
            ? BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        )
            : BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.time,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            message.text,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
        IconButton(
          icon: message.isLiked
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          iconSize: 30.0,
          color: message.isLiked
              ? Theme
              .of(context)
              .primaryColor
              : Colors.blueGrey,
          onPressed: () {},
        )
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme
                .of(context)
                .primaryColor,
            onPressed: () {
              Provider.of<ProviderBimbingan>(context,listen: false).sendChat(
                  nis: widget.nis,
                  nik: nik,
                  content: _controller.text,
                  idBimbigan: widget.idBimbigan,
                  senderId: nik
              ).then((value) {
                FocusScope.of(context).unfocus();
                _controller.clear();
              });
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value)async {
                print(value);

                Provider.of<ProviderUsers>(context,listen: false).updateStatus(
                  status: "mengetik..",
                );
              },
              onEditingComplete: ()async{
                print("asdsa");
                Provider.of<ProviderUsers>(context,listen: false).updateStatus(
                  status: "online",
                );
              },
              onSubmitted: (v)async{
                print("oke");
                Provider.of<ProviderUsers>(context,listen: false).updateStatus(
                  status: "online",
                );
              },

              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme
                .of(context)
                .primaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    getSession();
    timeago.setLocaleMessages('id', timeago.IdMessages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
//      backgroundColor: Theme
//          .of(context)
//          .primaryColor,
//      appBar: AppBar(
//        title: Text(
//          "Tika",
//          style: TextStyle(
//            fontSize: 28.0,
//            fontWeight: FontWeight.bold,
//          ),
//        ),
//        elevation: 0.0,
//
//      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -10,
                left: -10,
                right: -10,
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Color(0xFF527318),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20,left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                          Flexible(
                            child: Padding(
                              padding:
                              const EdgeInsets.only(right: 10, bottom: 0,left: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.asset(
                                  'assets/tika2.jpg',
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),

                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(top:25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
//                                  FutureProvider<ModelStatusSiswa>(create: (_) {
//                                    return ProviderUsers().getStatusSiswa(context:context,idUser: widget.idUser);
//                                  },
//                                  child: Consumer<ProviderUsers>(builder: (context,data,_){
//                                    print(data.modelStatusSiswa.data);
//                                    return Column(
//                                      mainAxisAlignment: MainAxisAlignment.start,
//                                      crossAxisAlignment: CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        Text("${data.modelStatusSiswa.data[0].namaSiswa}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
//                                        SizedBox(height: 5,),
//                                        data.modelStatusSiswa.data[0].status.toString()=="offline" ?
//                                        Text("${timeago.format(data.modelStatusSiswa.data[0].updatedAt, locale: 'id', allowFromNow: true)}",style: TextStyle(color: Colors.white))
//                                            :Text("${data.modelStatusSiswa.data[0].status}",style: TextStyle(color: Colors.white)),
//                                      ],
//                                    );
//                                  },),)

                                  FutureProvider(create: (_)=> ProviderUsers().getGuruBK(),
                                    child: Consumer<ProviderUsers>(builder: (context,data,_){
                                      return data.modelGuruBk.data!=null ? Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("${data.modelGuruBk.data[0].namaGuru}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                                          SizedBox(height: 5,),
                                          data.modelGuruBk.data[0].status.toString()=="offline" ?
                                          Text("${timeago.format(data.modelGuruBk.data[0].updatedAt, locale: 'id', allowFromNow: true)}",style: TextStyle(color: Colors.white))
                                              :Text("${data.modelGuruBk.data[0].status}",style: TextStyle(color: Colors.white)),
                                        ],
                                      ) : Container();
                                    },),),
//                                  FutureBuilder(
//                                    future: Provider.of<ProviderUsers>(context,listen: true).getStatusSiswa(idUser: widget.idUser),
//                                    builder: (context,AsyncSnapshot<ModelStatusSiswa> snapshot){
//                                      if(snapshot.connectionState==ConnectionState.done){
//                                        return Text("${snapshot.data.data[0].status}",style: TextStyle(color: Colors.white));
//                                      }else{
//                                        if(snapshot.data!=null){
//                                          return Column(
//                                            mainAxisAlignment: MainAxisAlignment.start,
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: <Widget>[
//                                              Text("${snapshot.data.data[0].namaSiswa}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
//                                              SizedBox(height: 5,),
//                                              snapshot.data.data[0].status.toString()=="offline" ?
//                                              Text("${timeago.format(snapshot.data.data[0].updatedAt, locale: 'id', allowFromNow: true)}",style: TextStyle(color: Colors.white))
//                                                  :Text("${snapshot.data.data[0].status}",style: TextStyle(color: Colors.white)),
//                                            ],
//                                          );
//                                        }else{
//                                          return Container();
//                                        }
//                                      }
//
//                                    },
//                                  ),

                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                )),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              bottom: 0,
              child:  Column(
                children: <Widget>[
                  ExpandableNotifier(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5, right: 10),
                        child: ScrollOnExpand(
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: <Widget>[
                                ExpandablePanel(
                                  theme: const ExpandableThemeData(
                                    headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                    tapBodyToExpand: true,
                                    tapBodyToCollapse: true,
                                    hasIcon: false,
                                  ),
                                  header: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          ExpandableIcon(
                                            theme: const ExpandableThemeData(
                                              expandIcon: Icons.arrow_right,
                                              collapseIcon: Icons.arrow_drop_down,
                                              iconColor: Colors.orange,
                                              iconSize: 28.0,
                                              iconRotationAngle: math.pi / 2,
                                              iconPadding:
                                              EdgeInsets.only(right: 5),
                                              hasIcon: false,
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "Isi Bimbingan",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .body2
                                                  ,
                                                ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   right: 12),
//                                               child: Text(
//                                                 "Nilai",
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .body2
//                                                 ,
//                                               ),
//                                             ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  expanded: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text("${widget.isiBimbingan}",style: TextStyle(fontSize: 16),)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
//                        child:  FutureProvider(create: (_)=>ProviderBimbingan().getListChat(idBimbingan: widget.idBimbigan),
//                          child: Consumer<ProviderBimbingan>(builder: (context,data,_){
//                            return ListView.builder(
//                              reverse: true,
//                              padding: EdgeInsets.only(top: 15.0),
//                              itemCount: data.modelListChat.data.length,
//                              itemBuilder: (BuildContext context, int i) {
//                                return Container(
//                                  margin: nik==data.modelListChat.data[i].senderId
//                                      ? EdgeInsets.only(
//                                    top: 8.0,
//                                    bottom: 8.0,
//                                    left: 80.0,
//                                  )
//                                      : EdgeInsets.only(
//                                    top: 8.0,
//                                    bottom: 8.0,
//                                  ),
//                                  padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
//                                  width: MediaQuery
//                                      .of(context)
//                                      .size
//                                      .width * 0.75,
//                                  decoration: BoxDecoration(
//                                    color: Colors.grey[100 ],
//                                    borderRadius: nik==data.modelListChat.data[i].senderId
//                                        ? BorderRadius.only(
//                                      topLeft: Radius.circular(15.0),
//                                      bottomLeft: Radius.circular(15.0),
//                                    )
//                                        : BorderRadius.only(
//                                      topRight: Radius.circular(15.0),
//                                      bottomRight: Radius.circular(15.0),
//                                    ),
//                                  ),
//                                  child: Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Text(
//                                        "${timeago.format(data.modelListChat.data[i].createdAt, locale: 'id', allowFromNow: true)}",
//                                        style: TextStyle(
//                                          color: Colors.blueGrey,
//                                          fontSize: 16.0,
//                                          fontWeight: FontWeight.w600,
//                                        ),
//                                      ),
//                                      SizedBox(height: 8.0),
//                                      Text(
//                                        "${data.modelListChat.data[i].contentMessage}",
//                                        style: TextStyle(
//                                          color: Colors.blueGrey,
//                                          fontSize: 16.0,
//                                          fontWeight: FontWeight.w600,
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                );
//                              },
//                            );
//                          },),),
                      ),
                    ),
                  ),
                  _buildMessageComposer(),
                ],
              ),)
          ],
        ),
      ),
    );
  }
}