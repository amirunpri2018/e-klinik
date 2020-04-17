import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dropdown_formfield.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'formulir_pasien.dart';
import 'daftar_ulang_pasien.dart';
// For changing the language
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:dropdown_formfield/dropdown_formfield.dart';
// import 'package:flutter_cupertino_localizations/flutter_cupertino_localizations.dart';

const appName = 'DAFTAR ULANG PASIEN IRJ';

void main() => runApp(MaterialApp(
      title: appName,
      // home: MyHomePage()
      // home:RegistrasiPasien(),
      home : RegistrasiPasien(),
));

// Registrasi Pasien
class RegistrasiPasien extends StatefulWidget {
  @override
  _RegistrasiPasienState createState() => _RegistrasiPasienState();
}

class _RegistrasiPasienState extends State<RegistrasiPasien> {
  // final items = List<String>.generate(20, (i) => "Item ${i + 1}"); // list for swipe
  final items = [
    '10923821 Aldi Hadistian',
    '12093812 Aldi Hadistian',
    '12983091 Aldi Hadistian',
    '12893721 Aldi Hadistian',
    '10928302 Aldi Hadistian',
    '12398192 Aldi Hadistian',
    '10298320 Aldi Hadistian',

  ];

  String _myActivity;
  // String _myActivityResult;
  final formKey = new GlobalKey<FormState>();
  bool cetakKartu = false;
  bool tanpaBiayaAwal = false;

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    // _myActivityResult = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registrasi Pasien"),
      ),
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
            DropDownFormField(
                  // titleText: 'My workout',
                  hintText: 'Please choose one',
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
                  dataSource: [
                    {
                      "display": "Running",
                      "value": "Running",
                    },
                    {
                      "display": "Climbing",
                      "value": "Climbing",
                    },
                    {
                      "display": "Walking",
                      "value": "Walking",
                    },
                    {
                      "display": "Swimming",
                      "value": "Swimming",
                    },
                    {
                      "display": "Soccer Practice",
                      "value": "Soccer Practice",
                    },
                    {
                      "display": "Baseball Practice",
                      "value": "Baseball Practice",
                    },
                    {
                      "display": "Football Practice",
                      "value": "Football Practice",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
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
                  // new Row(children: <Widget>[
                  //   new Text('No. '),
                  //   new Text('')
                  // ],
            ListView.builder(
              shrinkWrap: true, 
              physics: ClampingScrollPhysics(),
              itemCount: 100,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(index),
                  actionPane: SlidableDrawerActionPane(),
                  // actions: <Widget>[
                  //   IconSlideAction(
                  //     caption: 'Archive',
                  //     color: Colors.blue,
                  //     icon: Icons.archive,
                  //   ),
                  //   IconSlideAction(
                  //     caption: 'Share',
                  //     color: Colors.indigo,
                  //     icon: Icons.share,
                  //   ),
                  // ],
                  secondaryActions: <Widget>[
                    // IconSlideAction(
                    //   caption: 'Edit',
                    //   color: Colors.grey.shade200,
                    //   icon: Icons.edit,
                    //   onTap: (){
                    //      Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => Home()),
                    //     );
                    //   },
                    // ),
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





class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Data Pasien'),
      ),
      body: Column(children: <Widget>[
        Text('EditData'),
      ],),
    );  
  }
}