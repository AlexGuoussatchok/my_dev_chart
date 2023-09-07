class MyFilms {
  int? id;
  String brand;
  String film;
  String filmType;
  String filmSize;
  int filmIso;
  int framesNumber;
  String expirationDate;
  String quantity;

  MyFilms({
    this.id,
    required this.brand,
    required this.film,
    required this.filmType,
    required this.filmSize,
    required this.filmIso,
    required this.framesNumber,
    required this.expirationDate,
    required this.quantity,

  });

  // Define the toMap method to convert MyFilms to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'film': film,
      'filmType': filmType,
      'filmSize': filmSize,
      'filmIso': filmIso,
      'framesNumber': framesNumber,
      'expirationDate': expirationDate,
      'quantity': quantity,
    };
  }
}