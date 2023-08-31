import 'package:budget_tracker/helper/budget_helper.dart';
import 'package:budget_tracker/modals/db_modal.dart';
import 'package:get/get.dart';

class Budget_Controller extends GetxController {
  RxList<MaintableModal> mainList = <MaintableModal>[].obs;

  RxInt balance = 0.obs;

  RxList<MaintableModal> searchdata = <MaintableModal>[].obs;

  getBalance() async {
    balance(await BudgetHelper.budgetHelper.getBalance());
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
