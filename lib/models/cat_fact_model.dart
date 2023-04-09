
class CatFact {
  String fact;

  CatFact({required this.fact, });

  factory CatFact.fromJson(Map<String, dynamic> json) => CatFact(
    fact: json['fact'],
  );
}
