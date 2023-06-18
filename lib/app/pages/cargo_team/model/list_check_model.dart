class ListCheckModel {
  String? contnhap;
  String? bk;
  String? lwh;
  String? recscanner;
  String? xn1;

  String? cn1;
  String? cn2;

  ListCheckModel(
      {this.contnhap,
      this.bk,
      this.lwh,
      this.recscanner,
      this.xn1,
      this.cn1,
      this.cn2});

  ListCheckModel.fromJson(Map<String, dynamic> json) {
    contnhap = json['contnhap'];
    bk = json['bk'];
    lwh = json['lwh'];
    recscanner = json['recscanner'];
    xn1 = json['xn1'];

    cn1 = json['cn1'];
    cn2 = json['cn2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contnhap'] = contnhap;
    data['bk'] = bk;
    data['lwh'] = lwh;
    data['recscanner'] = recscanner;
    data['xn1'] = xn1;

    data['cn1'] = cn1;
    data['cn2'] = cn2;
    return data;
  }
}
