import 'package:applicationsondage/PageVisualiserSondage.dart';
import 'package:applicationsondage/pageConnection.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'PageFavoris.dart';
import 'SourceBidon.dart';
import 'creation_sondage.dart';
import 'main.dart';
import 'utilisateur.dart';

// GIT TEST 

class CompteUtilisateur extends StatelessWidget {
  const CompteUtilisateur({Key? key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<MyAppState>(context, listen: false);
    return MaterialApp(
        title: 'Compte utilisateur',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: appState.darkMode
              ? ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 246, 82, 160))
              : ColorScheme.fromSeed(seedColor: Colors.blue),
          scaffoldBackgroundColor: appState.darkMode
              ? Colors.black
              : const Color.fromARGB(255, 188, 236, 224),
        ));
  }
}

class PageCompteUtilisateur extends StatefulWidget {
  const PageCompteUtilisateur({Key? key});

  @override
  _PageCompteUtilisateurState createState() => _PageCompteUtilisateurState();
}

class _PageCompteUtilisateurState extends State<PageCompteUtilisateur> {
  bool darkMode = false;
  bool frenchLanguage = true;
  bool isEditing = false;
  var selectedIndex = 0;
  TextEditingController usernameController = TextEditingController();
  TextEditingController mdpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var appState = Provider.of<MyAppState>(context, listen: false);
    usernameController.text = appState.utilisateurLoggedIn?.username ?? '';
    mdpController.text = appState.utilisateurLoggedIn?.motDePasse ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compte Utilisateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nom d\'utilisateur',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: usernameController,
              enabled: isEditing,
              decoration: const InputDecoration(
                hintText: 'nom d\'utilisateur',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Mot de passe',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: mdpController,
              enabled: isEditing,
              decoration: const InputDecoration(
                hintText: 'mot de passe',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
                if (!isEditing) {
                  Utilisateur utilisateurActuel = appState.utilisateurLoggedIn!;

                  int indexUtilisateur = infoLogin.indexWhere((utilisateur) =>
                      utilisateur.username == utilisateurActuel.username &&
                      utilisateur.motDePasse == utilisateurActuel.motDePasse);

                  if (indexUtilisateur != -1) {
                    infoLogin[indexUtilisateur].username =
                        usernameController.text;
                    infoLogin[indexUtilisateur].motDePasse = mdpController.text;
                    appState.utilisateurLoggedIn = infoLogin[indexUtilisateur];
                  }
                  print(
                      "voici l'utilisateur  ${infoLogin[indexUtilisateur].username}");
                }
              },
              child: Text(isEditing ? 'Enregistrer' : 'Modifier'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Langue',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: frenchLanguage,
                  onChanged: (value) {
                    setState(() {
                      frenchLanguage = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Mode Sombre',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: darkMode,
                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                      appState.changerModeSombre();
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmation'),
                      content: const Text(
                          'Êtes-vous sûr de vouloir se deconnecter?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Annuler'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PageConnection(),
                              ),
                            );
                          },
                          child: Text('deconnecter'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Deconnexion"),
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
            selectedIndex: 3,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PageVisualiserSondages(
                        title: 'Application sondages',
                      ),
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
}
