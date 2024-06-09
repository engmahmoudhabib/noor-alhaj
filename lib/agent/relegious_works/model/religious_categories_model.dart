
class ReligiousCategories {
  int? id;
  String? name;
  String? created;

  ReligiousCategories({this.id, this.name, this.created});

  ReligiousCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created'] = created;
    return data;
  }
}

class ReligiousGuidnessCategories {
  int? id;
  String? name;
  String? created;

  ReligiousGuidnessCategories({this.id, this.name, this.created});

  ReligiousGuidnessCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created'] = this.created;
    return data;
  }
}
