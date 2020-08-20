import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smk_losarangg/providers/p_bimbingan.dart';
import 'package:smk_losarangg/screen/guru/guru_dataabsen.dart';

class DataJurusan extends StatefulWidget {
  @override
  _DataJurusanState createState() => _DataJurusanState();
}

class _DataJurusanState extends State<DataJurusan> {
  @override
  void initState() {
    Provider.of<ProviderBimbingan>(context, listen: false).getJurusan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProviderBimbingan>(
        builder: (context, value, child) {
          if(value.modelJurusan==null){
            return Center(
              child: CircularProgressIndicator(

              ),
            );
          } else {
            if (value.modelJurusan.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (value.modelJurusan.data.length == 0) {
              return Center(
                child: Text("Data Kosong"),
              );
            } else {
              return ListView.builder(
                  itemCount: value.modelJurusan.data.length,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  itemBuilder: (c, i) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => DataAbsen(idKelas: value.modelJ.data[i].idKelas, tanggal: DateFormat('yyyy-MM-dd').format(DateTime.now()),)));
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(value.modelJurusan.data[i].namaJurusan),
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
