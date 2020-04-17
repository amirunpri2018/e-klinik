import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dropdown_formfield.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int pilihOpsi;
  String _myActivity;
  // String _myActivityResult;
  final formKey = new GlobalKey<FormState>();
  bool cetakKartu = false;
  bool tanpaBiayaAwal = false;

  setPilihOpsi(int val) {
    setState(() {
      pilihOpsi = val;
      
    });
  }

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    // _myActivityResult = '';
  }
  
  final tab = new TabBar(
    tabs: <Widget>[
      new Tab(text: "Biodata",),
      new Tab(text: "Daftar Ulang",),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          padding: EdgeInsets.all(24),
          children: <Widget>[
              Text('Jenis Kunjungan'),
              Row(children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: pilihOpsi,
                            activeColor: Colors.green,
                            onChanged: (val) {
                              print("Lama");
                              setPilihOpsi(val);
                            },
                          ),
                          Text('Lama'),
                          Radio(
                            value: 2,
                            groupValue: pilihOpsi,
                            activeColor: Colors.green,
                            onChanged: (val) {
                              print("Baru");
                              setPilihOpsi(val);
                            },
                          ),
                          Text('Baru')
                    ],),
              Text('Tgl Kunjungan'),
              DateTimeForm(),
              
              Text('CARA BAYAR'),
              // Dropdown
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

              Text('TUJUAN POLIKLINIK'),
              // Dropdown
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

              Text('DOKTER'),
              // Dropdown
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
              Text('KELAS RAWAT'),
              // Dropdown
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
                Text('CATATAN'),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Catatan'
                  ),
                ),
                Row(children: <Widget>[
                   Checkbox(
                    value: cetakKartu,
                    onChanged: (bool value) {
                        setState(() {
                            cetakKartu = value;
                        });
                    },
                ),
                Text('Cetak Kartu')
                ],),
                 Row(children: <Widget>[
                   Checkbox(
                    value: tanpaBiayaAwal,
                    onChanged: (bool value) {
                        setState(() {
                            tanpaBiayaAwal = value;
                        });
                    },
                ),
                Text('Tanpa Biaya Awal *)')
                ],),
                Text('* Hanya Untuk Pasien yang tidak terkena biaya seperti Buka Jahitan'),
                Row(children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(top:15.0,right: 10.0),
                  child:
                      RaisedButton(
                        onPressed: () {},
                        child: const Text(
                          'Reset',
                          style: TextStyle(fontSize: 20)
                        ),
                      ),
                  
                ),
               new Container(
                  margin: const EdgeInsets.only(top:15.0,right: 10.0),
                  child:
                      RaisedButton(
                        onPressed: () {},
                        child: const Text(
                          'Simpan',
                          style: TextStyle(fontSize: 20)
                        ),
                      ),
                  
                ),

                ],)
          ],
        ));
  }
}

// Date Picker
class DateTimeForm extends StatefulWidget {
  @override
  _DateTimeFormState createState() => _DateTimeFormState();
}


class _DateTimeFormState extends State<DateTimeForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BasicDateField(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // Text('Basic date field (${format.pattern})',textAlign: TextAlign.right,),
      DateTimeField(
        format: format,
        decoration: 
        InputDecoration(
          labelText: "Tanggal Kunjungan",
          prefixIcon: Icon(Icons.calendar_today),
        ),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}
// end of datepicker