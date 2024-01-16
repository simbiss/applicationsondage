import 'package:applicationsondage/sondages.dart';
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
        uneQuestion: "What color is the sky?",
        listeReponses: <String>["Red", "Green", "Blue", "Yellow"]),
    Sondage(
        uneQuestion: "What color is the Sun?",
        listeReponses: <String>["Red", "Green", "Blue", "Yellow"]),
    Sondage(
        uneQuestion: "What is the human population?",
        listeReponses: <String>[
          "5 billion",
          "6 billion",
          "7 billion",
          "8 billion"
        ]),
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
