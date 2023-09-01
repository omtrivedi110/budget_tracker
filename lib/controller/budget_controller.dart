import 'package:budget_tracker/helper/budget_helper.dart';
import 'package:budget_tracker/modals/db_modal.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Budget_Controller extends GetxController {
  RxList<MaintableModal> mainList = <MaintableModal>[].obs;

  RxInt balance = 0.obs;
  RxInt datesum = 0.obs;

  RxList<MaintableModal> searchdata = <MaintableModal>[].obs;
  RxInt updateRow = 0.obs;

  getBalance() async {
    balance(await BudgetHelper.budgetHelper.getBalance());
  }

  updaTra(
      {required String rem,
      required int b,
      required String ty,
      required int id2}) async {
    updateRow(await BudgetHelper.budgetHelper
        .updateTran(rem: rem, b: b, ty: ty, id2: id2));
    getData();
  }

  datewise({required DateTime dateTime}) {
    String date = DateFormat('dd-MM-yyyy').format(dateTime);
    mainList.every((element) {
      if ((int.parse(element.date.split('-')[0]) <=
          int.parse(date.split('-')[0]))) {
        element.type == 'income'
            ? datesum.value += element.amt
            : datesum.value -= element.amt;
      }
      return (int.parse(element.date.split('-')[0]) <=
          int.parse(date.split('-')[0]));
    });
  }

  Future<List<MaintableModal>> getData() async {
    mainList(await BudgetHelper.budgetHelper.getData());
    // ignore: invalid_use_of_protected_member
    return mainList.value;
  }

  searchData({required String val}) async {
    searchdata(await BudgetHelper.budgetHelper.searchData(val: val));
  }
}
