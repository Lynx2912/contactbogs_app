class Person {
  final String firma;
  String billed;
  String navn;
  String alder;
  String job;
  String ynglingsret;
  Person(this.firma, this.billed, this.navn, this.alder, this.job,
      this.ynglingsret);

  static Person fromJson(json) {
    return Person(
      json['firma'],
      json['billed'],
      json['navn'],
      json['alder'],
      json['job'],
      json['ynglingsret'],
    );
  }

  Map<String, dynamic> toJson() => {
        'firma': firma,
        'billed': billed,
        'navn': navn,
        'alder': alder,
        'job': job,
        'ynglingsret': ynglingsret,
      };
}
