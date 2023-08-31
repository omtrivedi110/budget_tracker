import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Page_controller extends GetxController {
  PageController controller = PageController();

  RxInt curr_index = 0.obs;
  RxInt curr_category = (-1).obs;
  RxString income = "income".obs;
  RxBool theme = false.obs;

  changeTheme() {
    theme.value = !theme.value;
  }

  changeCategory({required String inc}) {
    income.value = inc;
  }

  changeIndex({required int index}) {
    curr_category.value = index;
  }

  changePage({required int index}) {
    curr_index.value = index;
    controller.animateToPage(
      index,
      duration: const Duration(
        milliseconds: 600,
      ),
      curve: Curves.easeInOut,
    );
  }
}
