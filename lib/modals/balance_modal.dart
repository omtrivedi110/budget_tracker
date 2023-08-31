class BalanceModal {
  final int id;
  final int balance;

  BalanceModal(this.id, this.balance);

  factory BalanceModal.fromMap({required Map data}) {
    return BalanceModal(data['id'], data['bal']);
  }
}
