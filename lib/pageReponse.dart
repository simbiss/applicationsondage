import 'package:applicationsondage/DetailsSondage.dart';
import 'package:applicationsondage/Votes.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'PageVisualiserSondage.dart';
import 'creation_sondage.dart';
import 'sondages.dart';
import 'main.dart';
import 'package:applicationsondage/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  bool hasVoted = false;

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
                        if (appState.hasVoted(
                                widget.sondage, appState.utilisateurLoggedIn) ==
                            true) {
                          setState(() {
                            hasVoted = true;
                          });
                        } else {
                          hasVoted = false;
                          widget.sondage.repondre(widget
                              .sondage.listeReponses.keys
                              .elementAt(selectedOption! - 1));

                          appState.addVote(Votes(
                              id: appState.votesDesSondages.length + 1,
                              sondage: widget.sondage,
                              utilisateur: appState.utilisateurLoggedIn));
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
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.btn_send),
                  ),
                  if (showError)
                    Text(
                      AppLocalizations.of(context)!.erreur_send_vote,
                      style: TextStyle(color: Colors.red),
                    ),
                  if (hasVoted)
                    Text(
                      AppLocalizations.of(context)!.already_voted,
                      style: TextStyle(color: Colors.red),
                    )
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
    );
  }
}
