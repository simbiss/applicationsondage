import 'package:applicationsondage/DetailsSondage.dart';
import 'package:applicationsondage/Votes.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'PageVisualiserSondage.dart';
import 'creation_sondage.dart';
import 'sondages.dart';
import 'main.dart';

class PageReponse extends StatefulWidget {
  const PageReponse({Key? key, required this.title, required this.sondage});

  final String title;
  final Sondage sondage;

  @override
  State<PageReponse> createState() => _PageReponseState();
}

class _PageReponseState extends State<PageReponse> {
  int? selectedOption;
  var selectedIndex = 0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    widget.sondage.uneQuestion,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.sondage.listeReponses.length,
                    itemBuilder: (BuildContext context, int index) {
                      String option =
                          widget.sondage.listeReponses.keys.elementAt(index);
                      return ListTile(
                        title: Text(option),
                        leading: Radio<int>(
                          value: index + 1,
                          groupValue: selectedOption,
                          onChanged: (int? value) {
                            setState(() {
                              selectedOption = value!;
                              print('Choix: $selectedOption - $option');
                            });
                          },
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedOption == null) {
                        setState(() {
                          showError = true;
                        });
                      } else {
                        showError = false;
                        widget.sondage.repondre(widget
                            .sondage.listeReponses.keys
                            .elementAt(selectedOption! - 1));

                        appState.addVote(Votes(
                          id: appState.votesDesSondages.length + 1,
                            sondage: widget.sondage,
                            utilisateur: appState.utilisateurLoggedIn)
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsSondages(
                              title: widget.sondage.uneQuestion,
                              sondage: widget.sondage,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Envoyer'),
                  ),
                  if (showError)
                    const Text(
                      'Veuillez choisir une option',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ],
        ),
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
                          title: "Application de sondage"),
                    ),
                  );
                }
                if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreationSondage(),
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
    );
  }
}
