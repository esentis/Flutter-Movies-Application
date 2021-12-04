class SpokenLanguage {
  SpokenLanguage({
    this.iso6391,
    this.name,
  });

  String? iso6391;
  String? name;

  factory SpokenLanguage.fromMap(Map<String, dynamic> json) => SpokenLanguage(
        iso6391: json['iso_639_1'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() => {
        'iso_639_1': iso6391,
        'name': name,
      };
}
