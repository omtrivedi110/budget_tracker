import 'package:budget_tracker/controller/page_controller.dart';
import 'package:budget_tracker/helper/budget_helper.dart';
import 'package:budget_tracker/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await BudgetHelper.budgetHelper.init();

  BudgetHelper.budgetHelper.getBalance();

  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  Page_controller controller = Get.put(Page_controller());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
      ],
    );
  }
}
