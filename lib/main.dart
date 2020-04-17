import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dropdown_formfield.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'formulir_pasien.dart';
import 'daftar_ulang_pasien.dart';

void main() => runApp(MaterialApp(
      home : RegistrasiPasien(),
));

// Registrasi Pasien
class RegistrasiPasien extends StatefulWidget {
  @override
  _RegistrasiPasienState createState() => _RegistrasiPasienState();
}

class _RegistrasiPasienState extends State<RegistrasiPasien> {
  // final items = List<String>.generate(20, (i) => "Item ${i + 1}"); // list for swipe

  // untuk list pasien
  final items = [
    '10923821 - Nama Pasien',
    '12093812 - Nama Pasien',
    '12983091 - Nama Pasien',
    '12893721 - Nama Pasien',
    '10928302 - Nama Pasien',
    '12398192 - Nama Pasien',
    '10298320 - Nama Pasien',

  ];

  // untuk dropdown no rm
  List datasources = [
      {
        "display": "123456789",
        "value": "123456789",
      },
      {
        "display": "123456789",
        "value": "123456789",
      },
    ];

  String _myActivity;
  final formKey = new GlobalKey<FormState>();
  bool cetakKartu = false;
  bool tanpaBiayaAwal = false;

  @override
  void initState() {
    super.initState();
    _myActivity = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registrasi Pasien"),
      ),
      // floating buttton onclick route to Form daftar Pasien
      floatingActionButton: FloatingActionButton(onPressed: (){
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PasienForm()),
        );
      },child: Icon(Icons.add)),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: <Widget>[
            Text('No RM'),
            // dropdown pilih no RM
            DropDownFormField(
                  hintText: 'Pilih No RM',
                  value: _myActivity,
                  onSaved: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  dataSource: datasources,
                  textField: 'display',
                  valueField: 'value',
                ),
                // Text field untuk cari Nomor RM
                 new Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari Nomor RM'
                        ),
                        style: new TextStyle(
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                      },
                    )
                  ]
                  ),
                  // hasil pasien dengan isi no rekam medik dengan nama
            ListView.builder(
              shrinkWrap: true, 
              physics: ClampingScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(index),
                  actionPane: SlidableDrawerActionPane(),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                    ),
                  ],
                  dismissal: SlidableDismissal(
                    child: SlidableDrawerDismissal(),
                  ),
                  child: ListTile(
                    title: Text('$index'),
                    onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                    },
                  ),
                );
              },
            ),
        ],
      )
    );
  }

}