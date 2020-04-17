import 'package:flutter/material.dart';
import 'biodata.dart' as biodata;
import 'form_daftar_ulang.dart' as formDaftarUlang;

class  Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  //create controller untuk tabBar
  TabController controller;

  @override

  void initState(){
    controller = new TabController(vsync: this, length: 2);
    //tambahkan SingleTickerProviderStateMikin pada class _HomeState
    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //create appBar
      appBar: new AppBar(
        //warna background
        // backgroundColor: Colors.lightGreen,
         //judul
         title: new Text("Tampilan Home "),
           //bottom
           bottom: new TabBar(
             controller: controller,
             tabs: <Widget>[
               new Tab(icon: new Icon(Icons.people),text: "Biodata"),
               new Tab(icon: new Icon(Icons.note),text: "Daftar Ulang"),
             ],
        ),
      ),
      body: new TabBarView(
        controller : controller,
        children: <Widget>[
            biodata.Biodata(),
            formDaftarUlang.MyHomePage(),
        ],
      ),
    );
  }
}