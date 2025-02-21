class CategoriesModel {
  dynamic id, image, name, description;

  CategoriesModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.image});

  factory CategoriesModel.fromJson(Map<String, dynamic> Categories) {
    return CategoriesModel(
      id: Categories['id'],
      image: Categories['image'],
      name: Categories['name'],
      description: Categories['description'],
    );
  }

  CategoriesModel fromJson(Map<String, dynamic> json) {
    return CategoriesModel.fromJson(json);
  }

  factory CategoriesModel.init() {
    return CategoriesModel(id: '', name: '', description: '', image: '');
  }

  fromJsonList(List<dynamic> jsonList) {
    List<CategoriesModel> data = [];
    for (var post in jsonList) {
      data.add(CategoriesModel.fromJson(post));
    }
    return data;
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'description': description, 'image': image};
}
