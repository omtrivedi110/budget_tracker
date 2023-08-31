import 'package:budget_tracker/controller/budget_controller.dart';
import 'package:budget_tracker/controller/page_controller.dart';
import 'package:budget_tracker/modals/db_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Search extends StatelessWidget {
  Search({super.key});

  Page_controller controller = Get.find();
  Budget_Controller budget_controller = Get.find();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(18),
      child: ListView(
        children: [
          SizedBox(
            height: height * 0.01,
          ),
          TextField(
            onChanged: (val) {
              budget_controller.searchData(val: val);
            },
            decoration: InputDecoration(
              hintText: "Electricity",
              labelText: "Search",
              suffixIcon: const Icon(Icons.search_sharp),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            ),
          ),
          SizedBox(
            height: height * 0.8,
            child: Obx(() {
              return ListView.builder(
                  itemCount: budget_controller.searchdata.value.length,
                  itemBuilder: (context, index) {
                    MaintableModal modal =
                        budget_controller.searchdata.value[index];
                    return ListTile(
                      title: Text(modal.remark),
                      trailing: Text(
                        modal.amt.toString(),
                        style: TextStyle(
                          color: modal.type == 'income'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      leading: Text(
                        modal.id.toString(),
                      ),
                    );
                  });
            }),
          )
        ],
      ),
    );
  }
}
