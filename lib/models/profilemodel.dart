class Person {
  final String firma;
  final String billed;
  final String navn;
  final String alder;
  final String job;
  final String ynglingsret;
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
