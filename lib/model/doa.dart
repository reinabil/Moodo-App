// To parse this JSON data, do
//
//     final doa = doaFromJson(jsonString);

import 'dart:convert';

List<Doa> doaFromJson(String str) =>
    List<Doa>.from(json.decode(str).map((x) => Doa.fromJson(x)));

String doaToJson(List<Doa> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Doa {
  Doa({
    this.id,
    this.grup,
    this.judul,
    this.lafaz,
    this.latin,
    this.arti,
    this.tentang,
    this.mood,
    this.tag,
  });

  final int? id;
  final String? grup;
  final String? judul;
  final String? lafaz;
  final String? latin;
  final String? arti;
  final String? tentang;
  final String? mood;
  final String? tag;

  factory Doa.fromJson(Map<String, dynamic> json) => Doa(
        id: json["id"],
        grup: json["grup"],
        judul: json["judul"],
        lafaz: json["lafaz"],
        latin: json["latin"],
        arti: json["arti"],
        tentang: json["tentang"],
        mood: json["mood"],
        tag: json["tag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grup": grup,
        "judul": judul,
        "lafaz": lafaz,
        "latin": latin,
        "arti": arti,
        "tentang": tentang,
        "mood": mood,
        "tag": tag,
      };

  String getJudul() {
    return judul!;
  }

  String getLafaz() {
    return lafaz!;
  }

  String getLatin() {
    return arti!;
  }

  String getArti() {
    return arti!;
  }

  String getMood() {
    return mood!;
  }
}
