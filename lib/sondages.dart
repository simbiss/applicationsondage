import 'package:applicationsondage/utilisateur.dart';

class Sondage {
  int id;
  String uneQuestion;
  Map<String, int> listeReponses;
  Utilisateur utilisateur;
  bool fini = false;

  Sondage(
      {required this.id,
      required this.uneQuestion,
      required this.listeReponses,
      required this.utilisateur});
}
