import 'package:applicationsondage/PageVisualiserSondage.dart';
import 'package:applicationsondage/utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'pageInscription.dart' as pageInscription;
import 'SourceBidon.dart' as SourceBidon;

class PageConnection extends StatelessWidget {
  const PageConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page Connection',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 250, 73, 73)),
        useMaterial3: true,
      ),
      home: const Connection(title: 'Application Sondage'),
    );
  }
}

class Connection extends StatefulWidget {
  const Connection({super.key, required this.title});
  final String title;

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomUtilisateurController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //information login A DÉPLACER DANS UN SOURCE BIDON

  //méthode vérification des informations login
  bool verificationCred(String username, String password, MyAppState appState) {
    for (var utilisateur in SourceBidon.infoLogin) {
      if (utilisateur.username == username &&
          utilisateur.motDePasse == password) {
        setState(() {
          {
            appState.utilisateurLoggedIn =
                Utilisateur(username: username, motDePasse: password);
          }
        });
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
                child: TextFormField(
                  controller: nomUtilisateurController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nom Utilisateur"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Un nom d\'utilisateur est requis';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Mot de passe"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Un mot de passe est requis';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (verificationCred(nomUtilisateurController.text,
                                passwordController.text, appState) ==
                            true) {
                          //navigation vers page principal de l'utilisateur apres connection

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageVisualiserSondages(
                                    title:
                                        "Application Sondage, ${nomUtilisateurController}")),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Nom d\'utilisateur/Mot de passe incorrect'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Completer tous les champs')),
                        );
                      }
                    },
                    child: const Text('Connexion'),
                  ),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  pageInscription.PageInscription()),
                        );
                      },
                      child: const Text('Inscription',
                          style: TextStyle(
                              color: Color.fromARGB(255, 187, 34, 34),
                              decoration: TextDecoration.underline)),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
