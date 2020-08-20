// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class SliversBasicPage extends StatefulWidget {
//   @override
//   _SliversBasicPageState createState() => _SliversBasicPageState();
// }

// class _SliversBasicPageState extends State<SliversBasicPage> {
//   String _timeString;

//   void _getTime() {
//     final DateTime now = DateTime.now();
//     final String formattedDateTime = _formatDateTime(now);
//     if (this.mounted) {
//       setState(() {
//         _timeString = formattedDateTime;
//       });
//     }
//   }

//   String _formatDateTime(DateTime dateTime) {
//     return DateFormat('kk:mm:ss').format(dateTime);
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     if (this.mounted) {
//       Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             backgroundColor: Color(0xFF28915E),
//             pinned: true, //biar tulisannya tetep ada pas discroll
//             actions: <Widget>[
//               Icon(
//                 Icons.notifications,
//                 color: Colors.white,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(100.0),
//                   child: Image.asset(
//                     'assets/tika2.jpg',
//                     height: 15,
//                     width: 35,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ],
//             floating: false,
//             expandedHeight: 300.0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30))),
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(
//                 'BK-SMKN 1 Losarang',
//                 style: TextStyle(color: Colors.white),
//               ),
//               background: Container(
//                 padding: const EdgeInsets.only(top: 100),
//                 child: Column(
//                   children: <Widget>[
//                     Image.asset(
//                       'assets/logo.png',
//                       height: 80,
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       _timeString,
//                       style: GoogleFonts.abhayaLibre(
//                           fontSize: 30,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 return Column(
//                   children: <Widget>[
//                     Container(
//                       margin: EdgeInsets.only(left: 20, right: 20, top: 20),
//                       padding: EdgeInsets.only(left: 20, right: 20),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.grey)),
//                       child: TextField(
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'Cari di sini ...'),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: List.generate(10, (index) {
//                           return Padding(
//                               padding: EdgeInsets.only(
//                                   bottom: 10, left: 15, right: 15),
//                               child: Card(
//                                 elevation: 2,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           bottom: 10, top: 10, left: 10),
//                                       child: ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(100.0),
//                                         child: Image.asset(
//                                           'assets/tika2.jpg',
//                                           height: 50,
//                                           width: 50,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Flexible(
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: <Widget>[
//                                             Text(
//                                               'Akademik',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 18),
//                                             ),
//                                             SizedBox(
//                                               height: 5,
//                                             ),
//                                             Text(
//                                               '2 Menit yang lalu',
//                                               style: TextStyle(
//                                                   fontSize: 14,
//                                                   fontStyle: FontStyle.italic),
//                                             ),
//                                             SizedBox(
//                                               height: 10,
//                                             ),
//                                             Text(
//                                               'Assalamualaikum, ibu saya ingin menceritakan terkait akademik saya. Assalamualaikum, ibu saya ingin menceritakan terkait akademik saya. Assalamualaikum, ibu saya ingin menceritakan terkait akademik saya. Assalamualaikum, ibu saya ingin menceritakan terkait akademik saya. Assalamualaikum, ibu saya ingin menceritakan terkait akademik saya.',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ));
//                         }).toList()),
//                   ],
//                 );
//               },
//               childCount: 1,
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: SpeedDial(
//         // both default to 16
//         marginRight: 18,
//         marginBottom: 20,
//         animatedIcon: AnimatedIcons.menu_close,
//         animatedIconTheme: IconThemeData(size: 22.0),
//         // this is ignored if animatedIcon is non null
//         // child: Icon(Icons.add),
//         visible: true,
//         // If true user is forced to close dial manually
//         // by tapping main button and overlay is not rendered.
//         closeManually: false,
//         curve: Curves.bounceIn,
//         overlayColor: Colors.black,
//         overlayOpacity: 0.5,
//         onOpen: () => print('OPENING DIAL'),
//         onClose: () => print('DIAL CLOSED'),
//         tooltip: 'Speed Dial',
//         heroTag: 'speed-dial-hero-tag',
//         backgroundColor: Color(0xFF28915E),
//         foregroundColor: Colors.white,
//         elevation: 8.0,
//         shape: CircleBorder(),
//         children: [
//           SpeedDialChild(
//               child: Icon(
//                 Icons.supervisor_account,
//                 color: Colors.white,
//               ),
//               backgroundColor: Color(0xFFFEB72B),
//               label: 'Bimbingan',
//               labelStyle: TextStyle(fontSize: 18.0),
//               onTap: () => print('FIRST CHILD')),
//           SpeedDialChild(
//             child: Icon(
//               Icons.history,
//               color: Colors.white,
//             ),
//             backgroundColor: Colors.red,
//             label: 'Riwayat',
//             labelStyle: TextStyle(fontSize: 18.0),
//             onTap: () => print('SECOND CHILD'),
//           ),
//           SpeedDialChild(
//             child: Icon(
//               Icons.info,
//               color: Colors.white,
//             ),
//             backgroundColor: Colors.green,
//             label: 'Tentang App',
//             labelStyle: TextStyle(fontSize: 18.0),
//             onTap: () => print('THIRD CHILD'),
//           ),
//         ],
//       ),
//     );
//   }
// }
