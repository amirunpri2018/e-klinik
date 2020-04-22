// import 'package:dismissable_listview/models/movie.dart';
import '../models/pasien.dart';
import 'package:flutter/material.dart';
import '../daftar_ulang_pasien.dart';

class PasienCard extends StatelessWidget {
  final Pasien pasien;

  PasienCard({this.pasien});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(pasien.noRm),
            subtitle: Text(pasien.nama),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          )
        ],
      ),
    );
  }
}