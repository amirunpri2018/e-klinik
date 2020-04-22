import '../data/list-pasien.dart';
import '../models/pasien.dart';
import '../widgets/pasien-card.dart';
import 'package:flutter/material.dart';

class PasienPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PasienPageState();
  }
}

class _PasienPageState extends State<PasienPage> {
  final List<Pasien> pasien = PasienList.getMovies();

  Widget _buildPasienList() {
    return Container(
      child: pasien.length > 0
          ? ListView.builder(
              shrinkWrap: true, 
              physics: ClampingScrollPhysics(),
              itemCount: pasien.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      pasien.removeAt(index);
                    });
                  },
                  secondaryBackground: Container(
                    child: Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    color: Colors.red,
                  ),
                  background: Container(),
                  child: PasienCard(pasien: pasien[index]),
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                );
              },
            )
          : Center(child: Text('No Items')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Movies'),
    //   ),
    //   body: _buildPasienList(),
    // );
    return Container(
      child: _buildPasienList(),
    );
  }
}