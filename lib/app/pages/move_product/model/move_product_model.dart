class MoveProductModel {
  String? bk;
  String? form;
  String? to;
  int? type;

  MoveProductModel({this.bk, this.form, this.to, this.type});

  MoveProductModel.fromJson(Map<String, dynamic> json) {
    bk = json['bk'];
    form = json['form'];
    to = json['to'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bk'] = bk;
    data['form'] = form;
    data['to'] = to;
    data['type'] = type;
    return data;
  }
}
