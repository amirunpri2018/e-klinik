import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';



class DaftarUlang extends FormBloc<String, String> {

  final jenisKunjungan = SelectFieldBloc(
    name: 'Jenis Kunjungan',
    items: ['Lama', 'Baru'],
    validators: [FieldBlocValidators.required],
  );

  final tglKunjungan = InputFieldBloc<DateTime, Object>(
    name: 'Tanggal Kunjungan',
    toJson: (value) => value.toUtc().toIso8601String(),
    validators: [FieldBlocValidators.required],
  );

  final caraBayar = SelectFieldBloc(
    name: 'Cara Bayar',
    items: ['Umum', 'Lain Lain'],
    validators: [FieldBlocValidators.required],
  );

  final poliTujuan = SelectFieldBloc(
    name: 'Poli Tujuan',
    items: ['Poli Umum', 'Lain Lain'],
    validators: [FieldBlocValidators.required],
  );

  final dokter = SelectFieldBloc(
    name: 'Dokter',
    items: ['dr. xxx', 'Lain Lain'],
    validators: [FieldBlocValidators.required],
  );

  final kelasRawat = SelectFieldBloc(
    name: 'Kelas Rawat',
    items: ['I','II','III','IV','V'],
    validators: [FieldBlocValidators.required],
  );

  final catatan = TextFieldBloc(
    name: 'Catatan',
    validators: [FieldBlocValidators.required],
  );

  final multiSelect1 = MultiSelectFieldBloc<String, dynamic>(
    items: [
      'Cetak Kartu',
      'Tanpa Biaya Tambahan'
    ]
  );

  DaftarUlang() {
    addFieldBlocs(
      fieldBlocs: [
        jenisKunjungan,
        tglKunjungan,
        caraBayar,
        poliTujuan,
        dokter,
        kelasRawat,
        catatan,
        multiSelect1
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

class DaftarUlangForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DaftarUlang(),
      child: Builder(
        builder: (context) {
          final formBloc = context.bloc<DaftarUlang>();

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
             
              body: 
              FormBlocListener<DaftarUlang, String, String>(
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

                        RadioButtonGroupFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.jenisKunjungan,
                          itemBuilder: (context, value) =>
                              value[0].toUpperCase() + value.substring(1),
                          decoration: InputDecoration(
                            labelText: 'Jenis Kunjungan',
                            // prefixIcon: SizedBox(),
                          ),
                        ),


                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: formBloc.tglKunjungan,
                          format: DateFormat('dd-mm-yyyy'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration(
                            labelText: 'Tanggal Kunjungan',
                            // prefixIcon: Icon(Icons.calendar_today),
                          ),
                        ),

                         DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.caraBayar,
                          decoration: InputDecoration(
                            labelText: 'Cara Bayar',
                            // prefixIcon: Icon(Icons.book),
                          ),
                          itemBuilder: (context, value) => value,
                        ),

                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.poliTujuan,
                          decoration: InputDecoration(
                            labelText: 'Poli Tujuan',
                            // prefixIcon: Icon(Icons.book),
                          ),
                          itemBuilder: (context, value) => value,
                        ),

                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.dokter,
                          decoration: InputDecoration(
                            labelText: 'dokter',
                            // prefixIcon: Icon(Icons.book),
                          ),
                          itemBuilder: (context, value) => value,
                        ),

                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.kelasRawat,
                          decoration: InputDecoration(
                            labelText: 'Kelas Rawat',
                            // prefixIcon: Icon(Icons.book),
                          ),
                          itemBuilder: (context, value) => value,
                        ),

                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.catatan,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Catatan',
                          ),
                        ),

                         CheckboxGroupFieldBlocBuilder<String>(
                          multiSelectFieldBloc: formBloc.multiSelect1,
                          itemBuilder: (context,item) => item,
                          decoration: InputDecoration(
                            labelText: 'Checkbox',
                          ),
                        ) ,  
                        
                        RaisedButton(
                          onPressed: formBloc.submit,
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 20)
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
              'Terima Kasih Telah Daftar Ulang',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_) => DaftarUlangForm())),
              icon: Icon(Icons.replay),
              label: Text('Back To Home'),
            ),
          ],
        ),
      ),
    );
  }
}
