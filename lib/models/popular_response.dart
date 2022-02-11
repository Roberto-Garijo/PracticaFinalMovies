// To parse this JSON data, do
//
//     final popularResponse = popularResponseFromMap(jsonString);

import 'dart:convert';

import 'package:practica_final_2/models/models.dart';
//Mitjançant el postman i el quicktype.io anam fent peticions a la api i amb el json que ens retorna anam mapejant totes les clases necessaries, com
//per exemple la classe PopularResponse. Un cop la copiam anam arreglant tots els errors que ens doni i repetim el procés amb totes les classes necessaries,

class PopularResponse {
    PopularResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory PopularResponse.fromJson(String str) => PopularResponse.fromMap(json.decode(str));

    factory PopularResponse.fromMap(Map<String, dynamic> json) => PopularResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}