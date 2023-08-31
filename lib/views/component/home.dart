import 'package:budget_tracker/controller/budget_controller.dart';
import 'package:budget_tracker/helper/budget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../modals/db_modal.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  Budget_Controller controller = Get.put(Budget_Controller());

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(18),
      child: FutureBuilder(
        future: controller.getData(),
        builder: (context, snap) {
          if (snap.hasData) {
            if (snap.data!.isEmpty) {
              return const Center(
                child: Text(
                  "Empty Data",
                  style: TextStyle(fontSize: 24),
                ),
              );
            } else {
              return ListView(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      " ₹ ${controller.balance.value} ",
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    height: height * 0.9,
                    child: ListView.builder(
                      itemCount: snap.data!.length,
                      itemBuilder: (context, index) {
                        MaintableModal modal = snap.data![index];
                        return Slidable(
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (val) {
                                    AlertDialog(
                                      title: const Text("Edit Transaction"),
                                      content: Form(
                                        key: formkey,
                                        child: Column(
                                          children: [
                                            TextFormField(),
                                            TextFormField(),
                                            TextFormField(),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            formkey.currentState!.validate();
                                            if (formkey.currentState!
                                                .validate()) {
                                              formkey.currentState!.save();
                                            }
                                          },
                                          child: const Text("Save"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                      ],
                                    );
                                  },
                                  icon: Icons.edit,
                                ),
                                SlidableAction(
                                  icon: Icons.delete,
                                  onPressed: (val) {
                                    BudgetHelper.budgetHelper
                                        .delete(id2: modal.id);
                                  },
                                ),
                              ]),
                          child: ListTile(
                            title: Text(modal.remark),
                            trailing: Text(
                              modal.amt.toString(),
                              style: TextStyle(
                                  color: modal.type == 'income'
                                      ? Colors.green
                                      : Colors.red),
                            ),
                            leading: Text(
                              modal.id.toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          } else if (snap.hasError) {
            return Center(
              child: Text("${snap.error}"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
