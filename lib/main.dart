import 'package:applicationsondage/sondages.dart';
import 'package:applicationsondage/utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:applicationsondage/PageVisualiserSondage.dart';

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
        home: const PageVisualiserSondages(title: 'Application Sondage'),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
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

  void addSondage(Sondage sondage) {
    sondages.add(sondage);
    notifyListeners();
  }

  void supprimerSondage(Sondage sondage) {
    sondages.remove(sondage);
    notifyListeners();
  }
}
