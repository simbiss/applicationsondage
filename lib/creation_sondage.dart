import 'package:applicationsondage/listeDesSondage.dart';
import 'package:flutter/material.dart';

class CreationSondage extends StatelessWidget {
  const CreationSondage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Créer un sondage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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

class Sondage {
  String question;
  List<String> reponses;

  Sondage({
    required this.question,
    required this.reponses,
  });
}

class _PageCreationState extends State<PageCreation> {
  int _nombresDeReponses = 0;
  TextEditingController _questionController = TextEditingController();
  List<TextEditingController> _responseControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
    Sondage sondage = Sondage(question: ques, reponses: reps);
    print('Enregistrement... ${sondage.question} ${sondage.reponses}');
    _listeSondages.add(sondage);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListeSondagesPage(listeSondages: _listeSondages),
      ),
    );
  }
}
