class RecordClass {
  int filmNumber;
  DateTime date;
  String film;
  String selectedIso;
  String filmType;
  String? camera;
  String? lenses;
  String developer;
  String dilution;
  String? developingTime;
  double temperature;
  String? comments;

  RecordClass({
    required this.filmNumber,
    required this.date,
    required this.film,
    required this.selectedIso,
    required this.filmType,
    required this.camera,
    required this.lenses,
    required this.developer,
    required this.dilution,
    required this.developingTime,
    required this.temperature,
    required this.comments,
  });
}
