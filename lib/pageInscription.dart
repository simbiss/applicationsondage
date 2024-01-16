import 'package:flutter/material.dart';
import 'pageConnection.dart' as pageConnection;
import 'SourceBidon.dart' as SourceBidon;

class PageInscription extends StatelessWidget {
  const PageInscription({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page d\'inscription',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 250, 73, 73)),
        useMaterial3: true,
      ),
      home: const Inscription(title: 'Application Sondage'),
    );
  }
}

class Inscription extends StatefulWidget {
  const Inscription({super.key, required this.title});
  final String title;

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomUtilisateurController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationPasswordController =
      TextEditingController();

//méthode pour vérification disponibilité du nom Utilisateur
  bool verificationDispoNomUtilisateur(String username) {
    for (String key in SourceBidon.infoLogin.keys) {
      if (username == key) {
        return true;
      }
    }
    return false;
  }

  bool verificationMdpIdentique(String mdp, String confirmationMdp) {
    if (mdp == confirmationMdp) {
      return true;
    }
    return false;
  }

  void ajoutNouvelleUtilisateur(String username, String mdp) {
    SourceBidon.infoLogin.addEntries([MapEntry(username, mdp)]);
  }

  @override
  Widget build(BuildContext context) {
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
                    } else if (verificationDispoNomUtilisateur(value) == true) {
                      return 'Nom d\'utilisateur non disponible';
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
                child: TextFormField(
                  controller: confirmationPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirmation mot de passe"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Un mot de passe est requis';
                    } else if (verificationMdpIdentique(
                            passwordController.text, value) ==
                        false) {
                      return 'Les mots de passe ne sont pas identique';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ajoutNouvelleUtilisateur(nomUtilisateurController.text,
                            passwordController.text);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  pageConnection.PageConnection()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Information non valide'),
                          ),
                        );
                      }
                    },
                    child: const Text('Créer compte'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
