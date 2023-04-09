
class CatFactModel {
  String fact;

  CatFactModel({required this.fact, });

  factory CatFactModel.fromJson(Map<String, dynamic> json) => CatFactModel(
    fact: json['fact'],
  );
}
