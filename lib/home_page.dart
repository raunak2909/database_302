import 'package:database_302/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

   //DBHelper dbHelper = DBHelper();
   DBHelper dbHelper = DBHelper.getDB();


    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
    );


  }
}