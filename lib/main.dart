import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/rendering.dart';
import 'pages/pasien.dart';
import 'formulir_pasien.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WizardForm(),
    );
  }
}

class WizardFormBloc extends FormBloc<String, String> {

  final pilihNoRm = SelectFieldBloc(
    name: 'Pilih No RM',
    items: ['XXX', 'XXX'],
    validators: [FieldBlocValidators.required],
  );

  final searchnoRm = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      // FieldBlocValidators.passwordMin6Chars,
    ],
  );

  WizardFormBloc() {
    addFieldBlocs(
      fieldBlocs: [pilihNoRm, searchnoRm],
    );
  }

  // bool _showEmailTakenError = true;

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

class WizardForm extends StatefulWidget {
  @override
  _WizardFormState createState() => _WizardFormState();
}

class _WizardFormState extends State<WizardForm> {

  ScrollController scrollController;
  bool dialVisible = true;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  Widget buildBody() {
    return ListView.builder(
      controller: scrollController,
      itemCount: 30,
      itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
    );
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      // onOpen: () => print('OPENING DIAL'),
      // onClose: () => print('DIAL CLOSED'),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.accessibility, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PasienForm()),
            )
          },
          label: 'Tambah Pasien Baru',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        // SpeedDialChild(
        //   child: Icon(Icons.brush, color: Colors.white),
        //   backgroundColor: Colors.green,
        //   onTap: () => {},
        //   label: 'Edit Pasien',
        //   labelStyle: TextStyle(fontWeight: FontWeight.w500),
        //   labelBackgroundColor: Colors.green,
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WizardFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = context.bloc<WizardFormBloc>();
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
                title: Text('Register Pasien'),
              ),
              floatingActionButton: buildSpeedDial(),
              body: SafeArea(
                child: FormBlocListener<WizardFormBloc, String, String>(
                  onSubmitting: (context, state) => LoadingDialog.show(context),
                  onSuccess: (context, state) {
                    LoadingDialog.hide(context);
                  },
                  onFailure: (context, state) {
                    LoadingDialog.hide(context);
                  },
                  child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                         DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.pilihNoRm,
                          decoration: InputDecoration(
                            labelText: 'Pilih No RM',
                            // prefixIcon: Icon(Icons.book),
                          ),
                          itemBuilder: (context, value) => value,
                        ),
                          TextFieldBlocBuilder(
                            textFieldBloc: formBloc.searchnoRm,
                            keyboardType: TextInputType.emailAddress,
                            // maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Cari No rm',
                              suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: null)
                            ),
                            ),
                          PasienPage(),
                      ],
              ),
            ),
          )
                )
              ),
            )
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
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => WizardForm())),
              icon: Icon(Icons.replay),
              label: Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
