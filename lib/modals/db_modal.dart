class DatabaseModal {
  final int id;
  final String name;

  DatabaseModal(this.id, this.name);

  factory DatabaseModal.fromDatabase({required Map data}) {
    return DatabaseModal(data['id'], data['name']);
  }
}

class MaintableModal {
  final int id;
  final String remark;
  final String type;
  final String cat;
  final String date;
  final String time;
  final int amt;

  MaintableModal(this.id, this.remark, this.type, this.cat, this.date,
      this.time, this.amt);

  factory MaintableModal.formMap({required Map data}) {
    return MaintableModal(
      data['id'],
      data['remarks'],
      data['type'],
      data['cat'],
      data['date'],
      data['time'],
      data['amt'],
    );
  }
}
