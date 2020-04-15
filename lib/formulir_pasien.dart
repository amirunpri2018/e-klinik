import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';



class FormulirPasienBloc extends FormBloc<String, String> {

  final noRM = TextFieldBloc(
    name: 'Nomor Rekam Medik',
    validators: [FieldBlocValidators.required],
  
  );

  final name = TextFieldBloc(
    name: 'Nama',
    validators: [FieldBlocValidators.required],
  );

  final gender = SelectFieldBloc(
    name: 'Jenis Kelamin',
    items: ['male', 'female'],
    validators: [FieldBlocValidators.required],
  );

  final birthDate = InputFieldBloc<DateTime, Object>(
    name: 'Tanggal Lahir',
    toJson: (value) => value.toUtc().toIso8601String(),
    validators: [FieldBlocValidators.required],
  );

  final lahir = TextFieldBloc(
    name: 'Tempat Lahir',
    validators: [FieldBlocValidators.required],
  );


final noBPJS = TextFieldBloc(
    name: 'Nomor BPJS',
    validators: [FieldBlocValidators.required],
  );

final agama = SelectFieldBloc(
    name: 'Agama',
    items: ['Islam','Kristen Katolik','Kristen Protestan','Budha','Hindu'],
    validators: [FieldBlocValidators.required],
  );

  final kawin = SelectFieldBloc(
    name: 'Status Pernikahan',
    items: ['Belum Kawin', 'Sudah Kawin', 'Cerai'],
    validators: [FieldBlocValidators.required],
  );

  final darah = SelectFieldBloc(
    name: 'Golongan Darah',
    items: ['A','AB','B','O'],
    validators: [FieldBlocValidators.required],
  );

final alamat = TextFieldBloc(
    name: 'Alamat',
    validators: [FieldBlocValidators.required],
  );

final kodepos = TextFieldBloc(
    name: 'Kode Pos',
    validators: [FieldBlocValidators.required],
  );

  final pendidikan = SelectFieldBloc(
    name: 'Pendidikan',
    items: ['SMA','S1','S2','S3','Lainnya'],
    validators: [FieldBlocValidators.required],
  );

  final kerja = SelectFieldBloc(
    name: 'Pekerjaan',
    items: ['Karyawan BUMN','Karyawan Swasta','PNS','TNI','POLRI','Wiraswasta'],
    validators: [FieldBlocValidators.required],
  );

  final hp = TextFieldBloc(
    name: 'Nomor Handphone',
    validators: [FieldBlocValidators.required],
  );

  final email = TextFieldBloc(
    name: 'E-Mail',
    validators: [FieldBlocValidators.required],
  );

  FormulirPasienBloc() {
    addFieldBlocs(
      fieldBlocs: [
        name,
        noRM,
        gender,
        birthDate,
        lahir,
        noBPJS,
        agama,
        kawin,
        darah,
        alamat,
        kodepos,
        pendidikan,
        kerja,
        hp,
        email,
      ],
    );
  }

  @override
  void onSubmitting() async {
    

    try {
      await Future<void>.delayed(Duration(milliseconds: 500));

      emitSuccess();
    } catch (e) {
      emitFailure();
    }
  }
}

class PasienForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormulirPasienBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = context.bloc<FormulirPasienBloc>();

          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: new Icon(Icons.list),
                title: Text('Formulir Pasien Baru'),
                actions: <Widget>[

                  FlatButton.icon(
                    color: Colors.blue,
                      icon: Icon(Icons.arrow_back, color:  Colors.white), //`Icon` to display
                      label: Text('KEMBALI',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      ), //`Text` to display
                      onPressed: () {
                      },                     
                   ),        

                  FlatButton.icon(
                    color: Colors.blue,
                      icon: Icon(Icons.save, color:  Colors.white), //`Icon` to display
                      label: Text('SIMPAN',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      ), //`Text` to display
                      onPressed: formBloc.submit,                     
                   ),                                   
                   
                  ],
                ),
             
              body: 
              FormBlocListener<FormulirPasienBloc, String, String>(
              onSubmitting: (context, state) {
                LoadingDialog.show(context);
              },

              onSuccess: (context, state) {
                LoadingDialog.hide(context);

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => SuccessScreen()));
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);

                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse)));
              },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.noRM,
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 15,
                          maxLengthEnforced: true,
                          decoration: InputDecoration(
                            labelText: 'Nomor Rekam Medik',
                            prefixIcon: Icon(Icons.assignment),
                          ),
                        ),

                         TextFieldBlocBuilder(
                          textFieldBloc: formBloc.name,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Nama Lengkap',
                            prefixIcon: Icon(Icons.people),
                          ),
                        ),

                        RadioButtonGroupFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.gender,
                          itemBuilder: (context, value) =>
                              value[0].toUpperCase() + value.substring(1),
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            prefixIcon: SizedBox(),
                          ),
                        ),


                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.lahir,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Kota Tempat Lahir',
                            prefixIcon: Icon(Icons.place),
                          ),
                        ),


                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: formBloc.birthDate,
                          format: DateFormat('dd-mm-yyyy'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration(
                            labelText: 'Tanggal Lahir',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                        ),


                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.noBPJS,
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 10,
                          maxLengthEnforced: true,
                          decoration: InputDecoration(
                            labelText: 'Nomor BPJS Kesehatan',
                            prefixIcon: Icon(Icons.card_membership),
                          ),
                        ),

                         DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.agama,
                          decoration: InputDecoration(
                            labelText: 'Agama',
                            prefixIcon: Icon(Icons.book),
                          ),
                          itemBuilder: (context, value) => value,
                        ),

                        RadioButtonGroupFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.kawin,
                          itemBuilder: (context, value) =>
                              value[0].toUpperCase() + value.substring(1),
                          decoration: InputDecoration(
                            labelText: 'Status Pernikahan',
                            prefixIcon: SizedBox(),
                          ),
                        ),

                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.darah,
                          decoration: InputDecoration(
                            labelText: 'Golongan Darah',
                            prefixIcon: Icon(Icons.perm_identity),
                          ),
                          itemBuilder: (context, value) => value,
                        ),

                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.alamat,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Alamat Lengkap',
                            prefixIcon: Icon(Icons.place),
                          ),
                        ),

                         TextFieldBlocBuilder(
                          textFieldBloc: formBloc.kodepos,
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 5,
                          maxLengthEnforced: true,
                          decoration: InputDecoration(
                            labelText: 'Kode Pos',
                            prefixIcon: Icon(Icons.local_post_office),
                          ),
                        ),

                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.pendidikan,
                          decoration: InputDecoration(
                            labelText: 'Pendidikan',
                            prefixIcon: Icon(Icons.school),
                          ),
                          itemBuilder: (context, value) => value,
                        ),

                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.kerja,
                          decoration: InputDecoration(
                            labelText: 'Pekerjaan',
                            prefixIcon: Icon(Icons.work),
                          ),
                          itemBuilder: (context, value) => value,
                        ),

                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.hp,
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 12,
                          maxLengthEnforced: true,
                          decoration: InputDecoration(
                            labelText: 'Nomor Handphone',
                            prefixIcon: Icon(Icons.local_phone),
                          ),
                        ),

                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email),
                          ),
                        ),
                        
                      
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Terima Kasih Telah Mendaftar',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_) => PasienForm())),
              icon: Icon(Icons.replay),
              label: Text('Back To Home'),
            ),
          ],
        ),
      ),
    );
  }
}
