class UserModel {
  String? manv;
  String? tennv;
  String? mabp;
  String? maquyen;
  String? makh;

  UserModel({this.manv, this.tennv, this.mabp, this.maquyen, this.makh});

  UserModel.fromJson(Map<String, dynamic> json) {
    manv = json['manv'];
    tennv = json['tennv'];
    mabp = json['mabp'];
    maquyen = json['maquyen'];
    makh = json['makh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['manv'] = manv;
    data['tennv'] = tennv;
    data['mabp'] = mabp;
    data['maquyen'] = maquyen;
    data['makh'] = makh;
    return data;
  }
}
