class ExperienceResponseDataModel {
  String? message;
  Data? data;

  ExperienceResponseDataModel({this.message, this.data});

  ExperienceResponseDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] as String?;
    data = json['data'] != null ? Data.fromJson(json['data'] as Map<String, dynamic>? ?? {}) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Experiences>? experiences;

  Data({this.experiences});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['experiences'] != null) {
      experiences = <Experiences>[];
      json['experiences'].forEach((v) {
        experiences!.add(Experiences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (experiences != null) {
      data['experiences'] = experiences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Experiences {
  int? id;
  String? name;
  String? tagline;
  String? description;
  String? imageUrl;
  String? iconUrl;

  Experiences({this.id, this.name, this.tagline, this.description, this.imageUrl, this.iconUrl});

  Experiences.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    tagline = json['tagline'] as String?;
    description = json['description'] as String?;
    imageUrl = json['image_url'] as String?;
    iconUrl = json['icon_url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tagline'] = tagline;
    data['description'] = description;
    data['image_url'] = imageUrl;
    data['icon_url'] = iconUrl;
    return data;
  }
}
