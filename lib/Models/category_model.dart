class CategoryModel{
  int id;
  String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    return CategoryModel(
      id: json['categoryId'],
      name: json['categoryName']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name
    };
  }
}