import 'package:flutter/material.dart';
import 'pageConnection.dart' as pageConnection;
import 'SourceBidon.dart' as SourceBidon;
import 'utilisateur.dart';
import 'package:applicationsondage/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
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
    for (var key in SourceBidon.infoLogin) {
      if (username == key.username) {
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
    SourceBidon.infoLogin.add(Utilisateur(username: username, motDePasse: mdp));
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.username),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.errer_username;
                    } else if (verificationDispoNomUtilisateur(value) == true) {
                      return AppLocalizations.of(context)!.unvalide_username;
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.password),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.errer_password;
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText:
                          AppLocalizations.of(context)!.password_confirmation),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.errer_password;
                    } else if (verificationMdpIdentique(
                            passwordController.text, value) ==
                        false) {
                      return AppLocalizations.of(context)!
                          .errer_non_identical_password;
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
                          SnackBar(
                            content: Text(
                                AppLocalizations.of(context)!.invalid_info),
                          ),
                        );
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.create_acc),
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
