import 'dart:convert';
 
import 'models.dart';
 //Mitjançant el postman i el quicktype.io anam fent peticions a la api i amb el json que ens retorna anam mapejant totes les clases necessaries, com
//per exemple la classe SearchResponse. Un cop la copiam anam arreglant tots els errors que ens doni i repetim el procés amb totes les classes necessaries,
class SearchResponse {
    SearchResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });
 
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;
 
    factory SearchResponse.fromJson(String str) => SearchResponse.fromMap(json.decode(str));
 
    factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}