import 'package:budget_tracker/modals/img_modal.dart';

String path = "assets/images/";

List<Map> allimg = [
  {
    'name': "bill",
    'path': '${path}bill.png',
  },
  {
    'name': "cash",
    'path': '${path}cash.png',
  },
  {
    'name': "communication",
    'path': '${path}communication.png',
  },
  {
    'name': "deposit",
    'path': '${path}deposit.png',
  },
  {
    'name': "food",
    'path': '${path}food.png',
  },
  {
    'name': "gift",
    'path': '${path}gift.png',
  },
  {
    'name': "health",
    'path': '${path}health.png',
  },
  {
    'name': "movie",
    'path': '${path}movie.png',
  },
  {
    'name': "other",
    'path': '${path}other.png',
  },
  {
    'name': "rupee",
    'path': '${path}rupee.png',
  },
  {
    'name': "salary",
    'path': '${path}salary.png',
  },
  {
    'name': "shopping",
    'path': '${path}shopping.png',
  },
  {
    'name': "transport",
    'path': '${path}transport.png',
  },
  {
    'name': "wallet",
    'path': '${path}wallet.png',
  },
  {
    'name': "withdraw",
    'path': '${path}withdraw.png',
  },
];

List<Img_modal> images = allimg.map((e) => Img_modal.fromMap(data: e)).toList();
