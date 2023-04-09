abstract class AbstractFactsApi {
  Future<String> fetchFact();
}

abstract class AbstractImageApi {
  Future<dynamic> loadImage();
}