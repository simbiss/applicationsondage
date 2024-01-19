import 'sondages.dart';
import 'utilisateur.dart';

class Votes {
  int id;
  Sondage? sondage;
  Utilisateur? utilisateur;

  Votes({
    required this.id, 
    this.sondage,
    this.utilisateur
  });
}