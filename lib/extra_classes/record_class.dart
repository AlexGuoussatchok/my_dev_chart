class RecordClass {
  final int filmNumber;
  final DateTime date;
  final String film;
  final int selectedIso;
  final String filmType;
  final String? camera;
  final String? lenses;
  final String developer;
  final String dilution;
  final String? developingTime;
  final double temperature;
  final String? comments;

  RecordClass({
    required this.filmNumber,
    required this.date,
    required this.film,
    required this.selectedIso,
    required this.filmType,
    this.camera,
    this.lenses,
    required this.developer,
    required this.dilution,
    this.developingTime,
    required this.temperature,
    this.comments,
  });
}
