import 'package:budget_tracker/controller/budget_controller.dart';
import 'package:budget_tracker/controller/page_controller.dart';
import 'package:budget_tracker/views/component/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../helper/budget_helper.dart';

// ignore: must_be_immutable
class Categorys extends StatelessWidget {
  Categorys({super.key});

  Page_controller controller = Get.find();
  String income = "";
  double amount = 0.0;
  String date = "";
  String time = "";
  String remark = "";
  Budget_Controller budget_controller = Get.find();
  DateTime d = DateTime.now();

  TimeOfDay? t = TimeOfDay.now();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double s = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Obx(() {
        return ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                " ₹ ${budget_controller.balance.value} ",
                style: const TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(
              height: s * 0.01,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    images.length,
                    (index) => GestureDetector(
                      onTap: () {
                        controller.changeIndex(index: index);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: controller.curr_category.value == index
                                ? Colors.black
                                : Colors.transparent,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(images[index].path),
                            Text(images[index].name),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: s * 0.04,
            ),
            if (controller.curr_category.value == 17)
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
                onFieldSubmitted: (val) {
                  if (val.isEmpty) {
                    Get.snackbar(
                      "Enter Something",
                      "Enter How you have spent/received",
                    );
                  }
                },
              )
            else
              Container(),
            Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (val) {
                      if (val!.isEmpty) {
                        Get.snackbar(
                          "Enter Something",
                          "Enter How you have spent/received",
                        );
                      } else {
                        remark = val;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Remarks",
                      hintText: "Electricity Bill",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: s * 0.05,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (val) {
                      if (val!.isEmpty) {
                        Get.snackbar(
                          "Enter Something",
                          "Enter How much money was",
                        );
                      } else {
                        amount = double.parse(val);
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Money",
                      hintText: "2000",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: s * 0.05,
            ),
            Obx(
              () {
                return CupertinoSegmentedControl(
                  children: const {
                    'income': Text("Income"),
                    'expense': Text("Expense"),
                  },
                  onValueChanged: (val) {
                    controller.changeCategory(inc: val);
                  },
                  groupValue: controller.income.value,
                );
              },
            ),
            SizedBox(
              height: s * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    d = (await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime.now(),
                    ))!;
                    date = DateFormat('dd-MM-yyyy').format(d);
                  },
                  child: const Text("Select Date"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    t = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 00, minute: 00),
                    );
                    // ignore: use_build_context_synchronously
                    time = t!.format(context);
                  },
                  child: const Text("Select Time"),
                ),
              ],
            ),
            SizedBox(
              height: s * 0.03,
            ),
            ElevatedButton(
              onPressed: () async {
                formkey.currentState!.save();
                if (formkey.currentState!.validate()) {
                  int a = await BudgetHelper.budgetHelper.insertMain(
                      remark2: remark,
                      amt2: amount.toInt(),
                      type2: controller.income.value,
                      cat2: images[controller.curr_category.value].name,
                      date2: date,
                      time2: time);
                  budget_controller.getBalance();
                  Get.snackbar("Updated !!", "$a affected....",
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      }),
    );
  }
}
