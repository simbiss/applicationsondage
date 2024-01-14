import 'package:flutter/material.dart';
import 'pageConnection.dart';
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

//méthode pour vérification disponibilité du nom Utilisateur
//..
//..

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
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {},
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
