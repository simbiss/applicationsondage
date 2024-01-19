import 'package:applicationsondage/DetailsSondage.dart';
import 'package:applicationsondage/PageCompte.dart';
import 'package:applicationsondage/PageFavoris.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:applicationsondage/main.dart';

import 'creation_sondage.dart';

class PageVisualiserSondages extends StatefulWidget {
  const PageVisualiserSondages({super.key, required this.title});
  final String title;

  @override
  State<PageVisualiserSondages> createState() => _PageVisualiserSondagesState();
}

class _PageVisualiserSondagesState extends State<PageVisualiserSondages> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.sondages.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Il y a aucun sondage disponible. Créer un si possible."),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
                "La liste des sondages, Bienvenue ${appState.utilisateurLoggedIn?.username}",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
          ),
          for (var unSondage in appState.sondages)
            Container(
              color: colorRotator(appState.sondages.indexOf(unSondage)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailsSondages(title: "", sondage: unSondage)),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.poll),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            unSondage.uneQuestion,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmation'),
                                content: const Text(
                                    'Êtes-vous sûr de vouloir supprimer ce sondage ?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Annuler'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      appState.supprimerSondage(unSondage);
                                    },
                                    child: Text('Supprimer'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
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
                if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PageCompteUtilisateur(),
                    ),
                  );
                }
                if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreationSondage(),
                    ),
                  );
                }
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PageFavoris(
                        title: 'Les sondages favoris',
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
    );
  }

  Color colorRotator(int index) {
    switch (index % 3) {
      case 0:
        return const Color.fromARGB(255, 54, 238, 224);
      case 1:
        return const Color.fromARGB(255, 246, 82, 160);
      case 2:
        return const Color.fromARGB(255, 244, 255, 97);
      default:
        return const Color.fromARGB(255, 54, 238, 94);
    }
  }
}
