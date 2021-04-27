// To parse this JSON data, do
//
//     final dzikir = dzikirFromJson(jsonString);

import 'dart:convert';

List<Dzikir> dzikirFromJson(String str) =>
    List<Dzikir>.from(json.decode(str).map((x) => Dzikir.fromJson(x)));

String dzikirToJson(List<Dzikir> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dzikir {
  Dzikir({
    this.id,
    this.judul,
    this.lafaz,
    this.dibaca,
    this.latin,
    this.arti,
    this.tentang,
    this.waktu,
  });

  final int? id;
  final String? judul;
  final String? lafaz;
  final String? dibaca;
  final String? latin;
  final String? arti;
  final String? tentang;
  final String? waktu;

  factory Dzikir.fromJson(Map<String, dynamic> json) => Dzikir(
        id: json["id"],
        judul: json["judul"],
        lafaz: json["lafaz"],
        dibaca: json["dibaca"],
        latin: json["latin"],
        arti: json["arti"],
        tentang: json["tentang"],
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "lafaz": lafaz,
        "dibaca": dibaca,
        "latin": latin,
        "arti": arti,
        "tentang": tentang,
        "waktu": waktu,
      };
}
