class MaterialModel {
  final String? name;
  final int? id;

  MaterialModel({this.name, this.id});

  factory MaterialModel.fromJson(Map<String, dynamic> json){
    return MaterialModel(id: json['id'] as int, name: json['nama_material']);
  }
}