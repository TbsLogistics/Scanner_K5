class ListMenuFeature {
  int? id;
  String? name;
  String? link;

  ListMenuFeature({this.id, this.name, this.link});

  ListMenuFeature.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['link'] = link;
    return data;
  }
}
