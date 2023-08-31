class Img_modal {
  final String name;
  final String path;

  Img_modal(this.name, this.path);

  factory Img_modal.fromMap({required Map data}) {
    return Img_modal(data['name'], data['path']);
  }
}
