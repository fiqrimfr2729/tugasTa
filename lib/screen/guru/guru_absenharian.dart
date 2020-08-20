import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';
import 'package:smk_losarangg/screen/guru/guru_dataabsen.dart';

class AbsenHarian extends StatefulWidget {
  @override
  _AbsenHarianState createState() => _AbsenHarianState();
}

class _AbsenHarianState extends State<AbsenHarian> {
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
                              builder: (context) => DataAbsen(idKelas: value.modelKelas.data[i].idKelas, tanggal: DateFormat('yyyy-MM-dd').format(DateTime.now()),)));
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
