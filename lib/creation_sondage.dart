import 'package:applicationsondage/PageVisualiserSondage.dart';
import 'package:applicationsondage/main.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'PageFavoris.dart';
import 'sondages.dart';
import 'package:applicationsondage/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
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
            selectedIndex: 2,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageVisualiserSondages(
                        title: AppLocalizations.of(context)!.survey,
                      ),
                    ),
                  );
                }
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageFavoris(
                        title: AppLocalizations.of(context)!.fav_survey,
                      ),
                    ),
                  );
                }
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: AppLocalizations.of(context)!.home_page,
              ),
              GButton(
                icon: Icons.favorite,
                text: AppLocalizations.of(context)!.favoris,
              ),
              GButton(
                icon: Icons.add,
                text: AppLocalizations.of(context)!.add,
              ),
              GButton(
                  icon: Icons.account_circle,
                  text: AppLocalizations.of(context)!.profil)
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
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.enter_question),
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
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.enter_nbr_answers),
            ),
            if (_nombresDeReponses > 4)
              Text(
                AppLocalizations.of(context)!.too_many_answers,
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
              child: Text(AppLocalizations.of(context)!.save_btn),
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

  void _onSavePressed() {
    String ques = _questionController.text;
    List<String> reps = [];
    Map<String, int> listeReponses = {};

    for (var reponse in _responseControllers) {
      reps.add(reponse.text);
    }
    for (var i = 0; i < reps.length; i++) {
      listeReponses.addEntries([MapEntry(reps[i], 0)]);
    }
    int indexSondage = context.read<MyAppState>().sondages.length + 1;
    Sondage sondage = Sondage(
        id: indexSondage,
        uneQuestion: ques,
        listeReponses: listeReponses,
        utilisateur: context.read<MyAppState>().utilisateurLoggedIn);

    print(
        'Enregistrement... ${sondage.uneQuestion} ${sondage.listeReponses} ${sondage.utilisateur?.username}');

    if (_isQuestionAlreadyExists(ques)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.survey_already_exists),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      context.read<MyAppState>().addSondage(sondage);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.success_creation),
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
