import 'package:applicationsondage/Votes.dart';
import 'package:applicationsondage/pageConnection.dart';
import 'package:applicationsondage/sondages.dart';
import 'package:applicationsondage/utilisateur.dart';
import 'package:applicationsondage/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Application Sondage',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 246, 82, 160)),
            scaffoldBackgroundColor: const Color.fromARGB(255, 188, 236, 224)),
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        home: const PageConnection(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  Utilisateur? utilisateurLoggedIn;
  bool _darkMode = false;
  bool get darkMode => _darkMode;
  void changerModeSombre() {
    _darkMode = !_darkMode;
    notifyListeners();
  }

  var sondages = <Sondage>[
    Sondage(
        id: 1,
        uneQuestion: "What color is the sky?",
        listeReponses: {'Red': 0, 'Green': 0, 'Blue': 0, 'Yellow': 0},
        utilisateur: Utilisateur(username: "admin", motDePasse: "abc")),
    Sondage(
        id: 2,
        uneQuestion: "What color is the Sun?",
        listeReponses: {'Red': 0, 'Green': 0, 'Blue': 0, 'Yellow': 0},
        utilisateur: Utilisateur(username: "admin", motDePasse: "abc")),
    Sondage(
        id: 3,
        uneQuestion: "What is the human population?",
        listeReponses: {
          '5 billion': 0,
          '6 billion': 0,
          '7 billion': 0,
          '8 billion': 0
        },
        utilisateur: Utilisateur(username: "admin", motDePasse: "abc")),
  ];

  var sondagesFavoris = <Sondage>[];

  var votesDesSondages = <Votes>[];

  void addSondage(Sondage sondage) {
    sondages.add(sondage);
    notifyListeners();
  }

  void addSondageFavori(Sondage sondage) {
    sondagesFavoris.add(sondage);
    notifyListeners();
  }

  void supprimerSondage(Sondage sondage) {
    sondages.remove(sondage);
    notifyListeners();
  }

  void supprimerSondageFavori(Sondage sondage) {
    sondagesFavoris.remove(sondage);
    notifyListeners();
  }

  void setUtilisateur(String username, String mdp) {
    utilisateurLoggedIn?.username = username;
    utilisateurLoggedIn?.motDePasse = mdp;
    notifyListeners();
  }

  void addVote(Votes vote) {
    votesDesSondages.add(vote);
    notifyListeners();
  }

  List<Votes> findAllVotesParSondage(Sondage sondage) {
    List<Votes> sondagesVotes = [];
    for (var unVote in votesDesSondages) {
      if (unVote.sondage == sondage) {
        sondagesVotes.add(unVote);
      }
    }
    return sondagesVotes;
  }

  bool hasVoted(Sondage sondage, Utilisateur? utilisateur) {
    List<Votes> sondagesVotes = findAllVotesParSondage(sondage);
    for (var unVote in sondagesVotes) {
      if (unVote.utilisateur == utilisateur) {
        return true;
      }
    }
    return false;
  }
}
