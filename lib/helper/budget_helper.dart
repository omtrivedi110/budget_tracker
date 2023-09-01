import 'dart:developer';
import 'package:budget_tracker/modals/balance_modal.dart';
import 'package:budget_tracker/modals/db_modal.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BudgetHelper {
  //Path
  late String rawdbPath;
  String dbName = "mydatabase.db";
  String isfirst = "isfirst";

  //Category
  String tbl_cat = "category";
  String img = "img";
  String title = "title";

  //Balance
  String tbl_bal = "bal";
  String bal = "bal";

  //Maindatabase
  String tbl_name = "Mybudget3";
  String id = "id";
  String remark = "remarks";
  String type = "type";
  String amt = "amt";
  String cat = "cat";
  String date = "date";
  String time = "time";

  GetStorage getStorage = GetStorage();

  BudgetHelper._();
  static final BudgetHelper budgetHelper = BudgetHelper._();

  late Database database;

  get isone {
    getStorage.read(isfirst) ?? false;
  }

  setfirst() {
    getStorage.write(isfirst, true);
  }

  init() async {
    rawdbPath = await getDatabasesPath();
    String path = join(rawdbPath, dbName);
    database = await openDatabase(path, version: 1, onCreate: (db, vers) {
      //category
      db.execute(
          "CREATE TABLE IF NOT EXISTS $tbl_cat($id INTEGER PRIMARY KEY AUTOINCREMENT,$title TEXT,$img BLOB)");

      //main
      db
          .execute(
              'CREATE TABLE IF NOT EXISTS $tbl_name($id INTEGER PRIMARY KEY AUTOINCREMENT,$remark TEXT,$amt INTEGER,$type TEXT CHECK($type IN("expense","income")),$cat TEXT,$date TEXT,$time TEXT)')
          .then(
            (value) => log("Table Created......."),
          );

      //balance
      db.execute(
          "CREATE TABLE IF NOT EXISTS $tbl_bal($id INTEGER PRIMARY KEY ,$bal INTEGER )");

      db.rawInsert("INSERT INTO $tbl_bal VALUES(101,0)");
    });
  }

  insertcatergory({required String name, required Uint8List img2}) {
    database
        .rawInsert("INSERT INTO $tbl_cat($title,$img) VALUES('$name',$img2)")
        .then(
          (value) => Get.snackbar("Successfully Added !!", "$value Updated"),
        );
  }

  Future<int> insertMain(
      {required String remark2,
      required int amt2,
      required String type2,
      required String cat2,
      required String date2,
      required String time2}) async {
    List sql = [remark2, amt2, type2, cat2, date2, time2];
    int a = await database.rawInsert(
        "INSERT INTO $tbl_name($remark,$amt,$type,$cat,$date,$time) VALUES(?,?,?,?,?,?)",
        sql);
    List tmp_data = await database.rawQuery("SELECT * FROM $tbl_bal");
    List<BalanceModal> bal_data =
        tmp_data.map((e) => BalanceModal.fromMap(data: e)).toList();
    int bal2 = bal_data[0].balance;
    if (type2 == "income") {
      bal2 += amt2;
      database.rawUpdate("UPDATE $tbl_bal SET $bal = $bal2 WHERE $id = 101");
      getBalance();
    } else {
      bal2 -= amt2;
      database.rawUpdate("UPDATE $tbl_bal SET $bal = $bal2 WHERE $id = 101");
      getBalance();
    }
    return a;
  }

  Future<int> updateTran(
      {required String rem,
      required int b,
      required String ty,
      required int id2}) async {
    List args = [rem, b, ty];
    String sql =
        "UPDATE $tbl_name SET $remark = ?,$amt = ?,$type = ? WHERE $id=$id2";
    return await database.rawUpdate(sql, args);
  }

  Future<int> getBalance() async {
    List tmp_data = await database.rawQuery("SELECT * FROM $tbl_bal");
    List<BalanceModal> bal_data =
        tmp_data.map((e) => BalanceModal.fromMap(data: e)).toList();
    if (bal_data.isEmpty) {
      insertBal();
      getBalance();
    }
    int bal2 = bal_data[0].balance;
    return bal2;
  }

  insertBal() {
    database.rawInsert("INSERT INTO $tbl_bal VALUES(101,0)");
  }

  insertbal({required int balance}) {
    database.rawUpdate("UPDATE $tbl_bal SET $bal = $balance WHERE $id = 101");
    Get.snackbar("Balance Updated", "$balance updated");
  }

  Future<List<MaintableModal>> getData() async {
    List tmpdata = await database.rawQuery("SELECT * FROM $tbl_name");
    List<MaintableModal> alldata =
        tmpdata.map((e) => MaintableModal.formMap(data: e)).toList();
    return alldata;
  }

  Future<int> delete({required int id2}) async {
    String sql = "DELETE FROM $tbl_name WHERE $id = $id2";
    return database.rawDelete(sql);
  }

  Future<List<MaintableModal>> searchData({required String val}) async {
    String sql = 'SELECT * FROM $tbl_name WHERE $remark LIKE "%$val%" ';
    List data = await database.rawQuery(sql);
    List<MaintableModal> alldata =
        data.map((e) => MaintableModal.formMap(data: e)).toList();
    return alldata;
  }
}
