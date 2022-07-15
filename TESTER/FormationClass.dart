class Formation {
  final String formation_id;
  final String categorie_id;
  final String titre;
  final String description;
  final String objectif_formation;
  final String competences;
  final String programme;
  final String debouches;
  final String employeurs;
  final String formation_prix;
  final String formation_support;
  final String formation_video;
  final String date_debut;
  final String date_fin;
  final String created_at;
  final String updated_at;

  Formation(
      {required this.formation_id,
      required this.categorie_id,
      required this.titre,
      required this.description,
      required this.objectif_formation,
      required this.competences,
      required this.programme,
      required this.debouches,
      required this.employeurs,
      required this.formation_prix,
      required this.formation_support,
      required this.formation_video,
      required this.date_debut,
      required this.date_fin,
      required this.created_at,
      required this.updated_at});

  factory Formation.fromJson(dynamic json) {
    return Formation(
        formation_id: json["formation_id"],
        categorie_id: json["categorie_id"],
        titre: json["titre"],
        description: json["description"],
        objectif_formation: json["objectif_formation"],
        competences: json["competences"],
        programme: json["programme"],
        debouches: json["debouches"],
        employeurs: json["employeurs"],
        formation_prix: json["formation_prix"],
        formation_support: json["formation_support"],
        formation_video: json["formation_video"],
        date_debut: json["date_debut"],
        date_fin: json["date_fin"],
        created_at: json["created_at"],
        updated_at: json["updated_at"]);
  }
  Map<String, dynamic> toJson() => {
        "formation_id": formation_id,
        "categorie_id": categorie_id,
        "titre": titre,
        "description": description,
        "objectif_formation": objectif_formation,
        "objectif_formation": competences,
        "programme": programme,
        "debouches": debouches,
        "debouches": employeurs,
        "formation_prix": formation_prix,
        "formation_support": formation_support,
        "formation_video": formation_video,
        "date_debut": date_debut,
        "date_fin": date_fin,
        "created_at": created_at,
        "updated_at": updated_at
      };
}
