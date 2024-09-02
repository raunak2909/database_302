import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{

  ///singleton class
  /// 1 creating a private constructor
  DBHelper._();

  /// 2 globally distribute
  static DBHelper getInstance() => DBHelper._();


  ///getDB

  Database? mDB;

  Future<Database> getDB() async{
    if(mDB!=null){
      return mDB!;
    } else {
      mDB = await openDB();
      return mDB!;
    }
  }

  Future<Database> openDB() async {

    var appDir = await getApplicationDocumentsDirectory();
    var dbPath = join(appDir.path, "notes.db");


    return openDatabase(dbPath, version: 1, onCreate: (db, version){

      /// create all your tables here

    });

  }


}