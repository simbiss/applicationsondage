import 'package:applicationsondage/PageVisualiserSondage.dart';
import 'package:applicationsondage/main.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'sondages.dart';

class CreationSondage extends StatelessWidget {
  const CreationSondage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Créer un sondage',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 246, 82, 160)),
          scaffoldBackgroundColor: const Color.fromARGB(255, 188, 236, 224)),
      home: const PageCreation(title: 'Page de création du sondage'),
    );
  }
}

class PageCreation extends StatefulWidget {
  const PageCreation({Key? key, required this.title});

  final String title;

  @override
  State<PageCreation> createState() => _PageCreationState();
}

class _PageCreationState extends State<PageCreation> {
  int _nombresDeReponses = 0;
  var selectedIndex = 2;
  TextEditingController _questionController = TextEditingController();
  List<TextEditingController> _responseControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 76, 82, 112),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 76, 82, 112),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(255, 3, 162, 184),
            gap: 12,
            padding: const EdgeInsets.all(20),
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PageVisualiserSondages(
                        title: 'Page de la liste des sondages',
                      ),
                    ),
                  );
                }
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.favorite,
                text: 'Favoris',
              ),
              GButton(
                icon: Icons.add,
                text: 'Ajouter',
              ),
              GButton(icon: Icons.account_circle, text: 'Profil')
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _questionController,
              decoration:
                  const InputDecoration(labelText: 'Entrez votre question'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _nombresDeReponses = int.tryParse(value) ?? 0;
                  _nombresDeReponses = _nombresDeReponses;
                  _responseControllers.clear();
                  if (_nombresDeReponses < 5) {
                    for (int i = 0; i < _nombresDeReponses; i++) {
                      _responseControllers.add(TextEditingController());
                    }
                  }
                });
              },
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Nombre de réponses'),
            ),
            if (_nombresDeReponses > 4)
              const Text(
                'Le nombre de réponses ne peut pas dépasser 4.',
                style: TextStyle(color: Colors.red),
              ),
            if (_nombresDeReponses < 5)
              for (int i = 0; i < _nombresDeReponses; i++)
                TextField(
                  controller: _responseControllers[i],
                  decoration: InputDecoration(labelText: 'Réponse ${i + 1}'),
                ),
            ElevatedButton(
              onPressed: _onSavePressed,
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSaveButtonEnabled() {
    if (_questionController.text.isEmpty) {
      return false;
    }
    for (var controller in _responseControllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  List<Sondage> _listeSondages = [];

  void _onSavePressed() {
    String ques = _questionController.text;
    List<String> reps = [];

    for (var reponse in _responseControllers) {
      reps.add(reponse.text);
    }

    Sondage sondage = Sondage(uneQuestion: ques, listeReponses: reps);

    print('Enregistrement... ${sondage.uneQuestion} ${sondage.listeReponses}');

    if (_isQuestionAlreadyExists(ques)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Un sondage avec la même question existe déjà!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      context.read<MyAppState>().addSondage(sondage);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sondage créé avec succès!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  bool _isQuestionAlreadyExists(String question) {
    var appState = context.read<MyAppState>();
    return appState.sondages.any((sondage) => sondage.uneQuestion == question);
  }
}
