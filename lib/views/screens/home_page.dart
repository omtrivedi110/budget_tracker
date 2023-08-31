import 'package:budget_tracker/controller/page_controller.dart';
import 'package:budget_tracker/helper/budget_helper.dart';
import 'package:budget_tracker/views/component/category.dart';
import 'package:budget_tracker/views/component/search.dart';
import 'package:budget_tracker/views/component/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  Page_controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget Tacker"),
        centerTitle: true,
        actions: [
          Obx(
            () {
              return IconButton(
                onPressed: () {
                  Get.changeThemeMode(
                    controller.theme.value ? ThemeMode.light : ThemeMode.dark,
                  );
                  controller.changeTheme();
                },
                icon: controller.theme.value
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode_outlined),
              );
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.account_balance_wallet),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Update Balance"),
                actions: [
                  TextField(
                    onSubmitted: (val) {
                      BudgetHelper.budgetHelper
                          .insertbal(balance: int.parse(val));
                    },
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: PageView(
        controller: controller.controller,
        onPageChanged: (index) {
          controller.curr_index.value = index;
        },
        children: [
          Home(),
          Categorys(),
          Search(),
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            currentIndex: controller.curr_index.value,
            onTap: (index) {
              controller.changePage(index: index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: "home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: "category"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined), label: "search"),
            ],
          );
        },
      ),
    );
  }
}
