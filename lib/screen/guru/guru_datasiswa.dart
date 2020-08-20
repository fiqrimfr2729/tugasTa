import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smk_losarangg/models/m_list_bimbingan.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';
import 'package:smk_losarangg/screen/guru/guru_dataabsen.dart';
import 'package:smk_losarangg/screen/guru/guru_detailsiswa.dart';

class DataSiswa extends StatefulWidget {
  @override
  _DataSiswaState createState() => _DataSiswaState();
}

class _DataSiswaState extends State<DataSiswa> {
  @override
  void initState() {
    Provider.of<ProviderBimbingan>(context, listen: false).getKelas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProviderBimbingan>(
        builder: (context, value, child) {
          if(value.modelKelas==null){
            return Center(
              child: CircularProgressIndicator(

              ),
            );
          } else {
            if (value.modelKelas.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (value.modelKelas.data.length == 0) {
              return Center(
                child: Text("Data Kosong"),
              );
            } else {
              return ListView.builder(
                  itemCount: value.modelKelas.data.length,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  itemBuilder: (c, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LihatDetailSiswa(idKelas: value.modelKelas.data[i].idKelas)));
                      },
                                          child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(value.modelKelas.data[i].namaKelas),
                                  Text(value.modelKelas.data[i].totalSiswa.toString())
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }
          }
        },
      ),
    );
  }
}
