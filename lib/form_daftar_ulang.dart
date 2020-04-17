import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class FormulirPasienBloc extends FormBloc<String, String> {

 
 // Jenis Kunjungan
  final jenisKunjungan = SelectFieldBloc(
    name: 'Jenis Kunjungan',
    items: ['Lama', 'Baru'],
  );

  // TGL KUNJUNGAN
  final tglKunjungan = InputFieldBloc<DateTime, Object>(
    name: 'Tanggal Kunjungan',
    toJson: (value) => value.toUtc().toIso8601String(),
  );

  // Cara Bayar
  final caraBayar = SelectFieldBloc(
      name: 'Cara Bayar',
      items: ['Umum','Lain Lain'],
  );
  
  // Tujuan Poliklinik
  final poliTujuan = SelectFieldBloc(
      name: 'Tujuan Poliklinik',
      items: ['POLI UMUM','LAIN LAIN'],
  );

  // dokter
  final dokter = SelectFieldBloc(
      name: 'Dokter',
      items: ['dr. XXX','LAIN LAIN'],
  );

  //kelas rawat
  final kelasRawat = SelectFieldBloc(
      name: 'Kelas Rawat',
      items: ['I','II','III','IV'],
  );

  // Catatan
  final catatan = TextFieldBloc(
    name: 'Catatan',
  );

  final multiSelect1 = MultiSelectFieldBloc<String, dynamic>(
    items: [
      'Cetak Kartu',
      'Tanpa Biaya Tambahan'
    ]
  );

  FormulirPasienBloc() {
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
              body: 
              FormBlocListener<FormulirPasienBloc, String, String>(
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
                            prefixIcon: SizedBox(),
                          ),
                        ),

                        // tgl kunjungan
                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: formBloc.tglKunjungan,
                          format: DateFormat('dd-mm-yyyy'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration(
                            labelText: 'Tanggal Kunjungan',jyth
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                        ),

                        //dropdown
                         DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.caraBayar,
                          decoration: InputDecoration(
                            labelText: 'Cara Bayar',
                            // prefixIcon: Icon(Icons.book),
                          ),
                          itemBuilder: (context, value) => value,
                        ),

                         //dropdown
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
                            labelText: 'Dokter',
                            prefixIcon: Icon(Icons.perm_identity),
                          ),
                          itemBuilder: (context, value) => value,
                        ),

                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.kelasRawat,
                          decoration: InputDecoration(
                            labelText: 'Kelas Rawat',
                            prefixIcon: Icon(Icons.perm_identity),
                          ),
                          itemBuilder: (context, value) => value,
                        ),

                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.catatan,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Alamat Lengkap',
                            // prefixIcon: Icon(Icons.place),
                          ),
                        ),

                        CheckboxGroupFieldBlocBuilder<String>(
                          multiSelectFieldBloc: formBloc.multiSelect1,
                          itemBuilder: (context,item) => item,
                          decoration: InputDecoration(
                            labelText: 'Checkbox',
                          ),
                        ) ,      
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
