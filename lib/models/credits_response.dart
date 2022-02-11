// To parse this JSON data, do
//
//     final creditsResponse = creditsResponseFromMap(jsonString);
import 'models.dart';
//Mitjançant el postman i el quicktype.io anam fent peticions a la api i amb el json que ens retorna anam mapejant totes les clases necessaries, com
//per exemple la classe CreditsResponse. Un cop la copiam anam arreglant tots els errors que ens doni i repetim el procés amb totes les classes necessaries,
class CreditsResponse {
    CreditsResponse({
        required this.id,
        required this.cast,
    });

    int id;
    List<Cast> cast;

    factory CreditsResponse.fromJson(String str) => CreditsResponse.fromMap(json.decode(str));

    factory CreditsResponse.fromMap(Map<String, dynamic> json) => CreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
    );
}
