import 'package:flutter/material.dart';

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
  Map<String, String> infoLogin = {
    'admin': 'abc',
    'user1': 'abc1',
    'user2': 'abc2',
    'user3': 'abc3'
  };

  bool verificationCred(String username, String password) {
    for (String key in infoLogin.keys) {
      if (key == username && infoLogin[key] == password) {
        return true;
      }
    }
    return false;
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (verificationCred(nomUtilisateurController.text,
                                passwordController.text) ==
                            true) {
                          //navigation vers page login

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('TEST VALIDATION CORRECTE'),
                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Page principal'),
        ),
        body: Column(
          children: [
            Text(email),
            Center(
                child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Go back!"),
            ))
          ],
        ));
  }
}
